class Admin::OrdersController < ApplicationController
  before_filter :require_admin

  def index
    @count = current_store.orders.size
    @orders = current_store.orders.by_status(params[:status]).all
    @statuses = current_store.orders.count(group: :status)
    @active_tab = params[:status] || 'all'
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if params[:update_status]
      @order.update_status
    end
    redirect_to(:back)
  end
end
