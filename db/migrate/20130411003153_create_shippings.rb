class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.references :user
      t.references :order
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps
    end
    add_index :shippings, :user_id
    add_index :shippings, :order_id
  end
end
