class CheckoutController < ApplicationController
  before_filter :find_or_create_cart

  def show
  end

  def create
    # but the password and password confirmation is blank
    checkout_user = user_for_order(params[:user][:email],params[:user])
    # store this user as the current user
    # then continue with the checkout process
    # shipping_params = params[:shipping].merge(user_id: checkout_user.id)
    # @shipping = Shipping.create(shipping_params)
    # redirect_to user_orders_path(checkout_user.id)
    # redirect_to user_orders_path(checkout_user)
    redirect_to orders_path, action: :create
  end

  def user_for_order(email_address,data)
    user = current_user
    user ||= User.find_by_email(email_address)
    user ||= User.create_public_user(data)
    user
  end

end
