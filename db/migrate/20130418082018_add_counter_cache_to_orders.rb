class AddCounterCacheToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_count, :integer, default: 0
  end
end
