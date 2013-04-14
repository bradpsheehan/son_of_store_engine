class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.references :user
      t.references :order

      t.timestamps
    end
    add_index :billings, :user_id
    add_index :billings, :order_id
  end
end
