class Order < ActiveRecord::Base
  attr_accessible :status,
                  :user_id,
                  :store_id,
                  :url
  
  belongs_to :user
  belongs_to :store
  
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  
  has_one :billing
  has_one :shipping

  validates :user_id, presence: true
  validates :status, presence: true,
                    inclusion: {in: %w(pending cancelled paid shipped returned),
                                  message: "%{value} is not a valid status" }

  def self.by_status(status)
    if status.present? && status != 'all'
      order.where(status: status)
    else
      scoped
    end
  end

  def self.create_and_charge(params)
    order_url = string_gen

    order = create(status: 'pending', url: order_url, user_id: params[:user].id)

    params[:cart].items.each do |cart_item|
      order.order_items.create(product_id: cart_item.product.id,
                               unit_price: cart_item.unit_price,
                               quantity: cart_item.quantity)
    end

    payment = Payment.new_with_charge(token: params[:token],
                                      price: order.total,
                                      email: params[:user].email,
                                      order: order)
    order
  end

  def update_status
    next_status = { 'pending' => 'cancelled',
                    'paid' => 'shipped',
                    'shipped' => 'returned' }
    self.status = next_status[self.status]
    self.save
  end

  def total
    if order_items.present?
      order_items.map {|order_item| order_item.subtotal }.inject(&:+)
    else
      0
    end
  end

  def self.string_gen
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    value = (0...10).map{ o[rand(o.length)] }.join
    value
  end
end
