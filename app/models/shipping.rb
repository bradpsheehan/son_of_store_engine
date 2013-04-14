class Shipping < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  attr_accessible :city, :state, :street, :zipcode

  validates :street, presence: true
  validates :state, presence: true, length: 2
  validates :zipcode, presence: true, length: 5
  validates :city, presence: true
end
