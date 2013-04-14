class Shipping < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  attr_accessible :city, :state, :street, :zipcode, :user_id, :order_id

  validates :street, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :city, presence: true
end
