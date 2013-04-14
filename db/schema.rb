# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130413231324) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "state"
    t.string   "zipcode"
    t.string   "city"
    t.string   "type"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], :name => "index_addresses_on_addressable_type_and_addressable_id"

  create_table "billings", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "billings", ["order_id"], :name => "index_billings_on_order_id"
  add_index "billings", ["user_id"], :name => "index_billings_on_user_id"

  create_table "categories", :force => true do |t|
    t.integer  "store_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_products", :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "unit_price", :precision => 8, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], :name => "index_order_items_on_product_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "products", :force => true do |t|
    t.integer  "store_id"
    t.string   "title"
    t.text     "description"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.string   "status"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "shippings", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "shippings", ["order_id"], :name => "index_shippings_on_order_id"
  add_index "shippings", ["user_id"], :name => "index_shippings_on_user_id"

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.string   "description"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_store_roles", :force => true do |t|
    t.integer  "store_id"
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_store_roles", ["store_id"], :name => "index_user_store_roles_on_store_id"
  add_index "user_store_roles", ["user_id"], :name => "index_user_store_roles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "full_name"
    t.string   "display_name"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.boolean  "uber",                         :default => false
    t.boolean  "registered",                   :default => true
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
