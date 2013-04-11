class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :display_name, :email, :full_name,
                  :admin, :password, :password_confirmation

  validates_confirmation_of :password,
                            message: "passwords did not match", if: :password
  validates_presence_of :password, :on => :create
  # validates :full_name, presence: :true
  validates :email, presence: :true, uniqueness: :true,
            format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  validates :display_name, length: { in: 2..32 }, allow_blank: :true

  has_many :orders
  has_one  :shipping

  def default_values
    self.admin = false
  end

  # option 2
  def god_given_name
    (full_name || "Customer").titleize
  end

  def self.create_public_user(data)
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    password = (0...50).map{ o[rand(o.length)] }.join
    # option 1
    # User.create({ password: password, password_confirmation: password }.merge(data) )
    User.create({ full_name: "Customer", password: password, password_confirmation: password }.merge(data) )
  end
end
