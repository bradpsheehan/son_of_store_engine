class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :path
      t.string :description
      t.string :status,       default: 'pending'

      t.timestamps
    end
  end
end
