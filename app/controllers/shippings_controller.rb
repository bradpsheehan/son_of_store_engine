class ShippingsController < ApplicationController
  def create
    @shipping = Shipping.create(params[:shipping])
  end
end