class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :display_name,
                  :email,
                  :full_name,
                  :password,
                  :password_confirmation,
                  :registered,
                  :uber

  has_one :billing
  has_one :shipping

  validates_confirmation_of :password,
                            message: "passwords did not match", if: :password
  validates_presence_of :password, :on => :create
  # validates :full_name, presence: :true
  validates :email, presence: :true, uniqueness: :true,
            format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  validates :display_name, length: { in: 2..32 }, allow_blank: :true

  has_many :orders

  has_many :user_store_roles
  has_many :stores, through: :user_store_roles

  def uber_up
    self.uber = true
    self.save
  end

  def uber?
    self.uber
  end

  def self.create_public_user(data)
    password = string_gen
    User.create({ full_name: "Customer", password: password, password_confirmation: password, registered: false }.merge(data) )
  end

  def self.string_gen
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    value = (0...50).map{ o[rand(o.length)] }.join
    value
  end
end
