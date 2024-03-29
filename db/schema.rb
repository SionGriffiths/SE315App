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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151206215452) do

  create_table "baskets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "wine_id"
    t.integer  "basket_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
  end

  add_index "line_items", ["basket_id"], name: "index_line_items_on_basket_id"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["wine_id"], name: "index_line_items_on_wine_id"

  create_table "orders", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "base_rest_url"
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "all_wines_url"
    t.string   "new_orders_url"
    t.string   "last_update"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "wines", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "short_description"
    t.string   "country_of_origin"
    t.string   "grape_type"
    t.boolean  "vegetarian"
    t.decimal  "price"
    t.string   "product_number"
    t.string   "bottle_size"
    t.string   "pic_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "supplier_id"
  end

  add_index "wines", ["supplier_id"], name: "index_supplier_id"

end
