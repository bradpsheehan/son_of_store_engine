class OrdersController < ApplicationController
  # before_filter :require_login

  def index
    @orders = current_user.orders
  end

  def show
    order = Order.find(params[:id])

    current_user = User.find(session[:user_id])

    if current_user.id == order.user_id
      @order = Order.find(params[:id])
    else
      redirect_to account_orders_path
    end
  end

  def create
    session[:user_id] = user_for_order.id

    @order = Order.create_and_charge(cart: current_cart,
                                     user: user_for_order,
                                     token: params[:stripeToken])
    # fail @order.inspect
    if @order.valid?
      session[:cart] = current_cart.destroy

      shipping_params = params[:shipping].merge(user_id: user_for_order.id, order_id: @order.id)
      shipping = Shipping.create(shipping_params)

      billing_params = params[:billing].merge(user_id: user_for_order.id, order_id: @order.id)
      billing = Billing.create(billing_params)

      Mailer.order_confirmation(user_for_order, @order).deliver
      redirect_to account_order_path(@order),
        :notice => "Order submitted!"
    else
      redirect_to cart_path, :notice => "Checkout failed."
    end
  end

  def buy_now
    @order = Order.create_and_charge(cart: Cart.new({params[:order] => '1'}),
                                     user: user_for_order(params[:order][:email]),
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
    if current_user
      user = current_user
    else
      email_address = params[:user][:email]
      user ||= User.find_by_email(email_address)
      user ||= User.create_public_user(params[:user])
    end
    user
  end
end
