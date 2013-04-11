class Shipping < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  attr_accessible :city, :state, :street, :zipcode
end
