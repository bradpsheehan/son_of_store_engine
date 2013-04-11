class OrdersController < ApplicationController
  before_filter :require_login

  def index
    @orders = current_user.orders
  end

  def show
    order = Order.find(params[:id])
    if current_user.id == order.user_id
      @order = Order.find(params[:id])
    else
      redirect_to account_orders_path
    end
  end

  def create
    @order = Order.create_and_charge(cart: current_cart,
                                     user: user_for_order,
                                     token: params[:stripeToken])
    if @order.valid?
      session[:cart] = current_cart.destroy
      Mailer.order_confirmation(user_for_order, @order).deliver
      redirect_to account_order_path(@order),
        :notice => "Order submitted!"
    else
      redirect_to cart_path, :notice => "Checkout failed."
    end
  end

  def buy_now
    @order = Order.create_and_charge(cart: Cart.new({params[:order] => '1'}),
                                     user: user_for_order,
                                     token: params[:stripeToken])
    if @order.valid?
      session[:cart] = current_cart.destroy
      Mailer.order_confirmation(user_for_order, @order).deliver
      redirect_to account_order_path(@order),
        :notice => "Order submitted!"
    else
      redirect_to :back, :notice => "Checkout failed."
    end
  end

  private

  def user_for_order
    # is there a current_user?
    #   is there a user by email address?
    #     generate a user by email adddress, assigning a random password
    user = current_user
    user ||= User.find_by_email(email_adddress)
    user ||= User.create_public_user
    user
  end

  
end
