class CheckoutController < ApplicationController
  before_filter :find_or_create_cart

  def show
    # if current_user == false
    #   current_user = User.create(:username)
    # end
  end
end