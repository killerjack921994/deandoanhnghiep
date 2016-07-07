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

ActiveRecord::Schema.define(version: 20160628013403) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.date     "birthday"
    t.text     "description"
    t.string   "homeland"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.string   "image_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "image"
    t.integer  "staff_id"
    t.integer  "author_id"
    t.integer  "manufacturer_id"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id"
  add_index "books", ["manufacturer_id"], name: "index_books_on_manufacturer_id"
  add_index "books", ["staff_id"], name: "index_books_on_staff_id"

  create_table "books_categories", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "category_id"
  end

  add_index "books_categories", ["book_id"], name: "index_books_categories_on_book_id"
  add_index "books_categories", ["category_id"], name: "index_books_categories_on_category_id"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "name"
    t.text     "comment"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "staff_id"
  end

  add_index "comments", ["book_id"], name: "index_comments_on_book_id"
  add_index "comments", ["staff_id"], name: "index_comments_on_staff_id"

  create_table "line_items", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "cart_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
  end

  add_index "line_items", ["book_id"], name: "index_line_items_on_book_id"
  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "name"
    t.string   "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "payment"
    t.integer  "staff_id"
    t.string   "process"
  end

  add_index "orders", ["staff_id"], name: "index_orders_on_staff_id"

  create_table "staffs", force: :cascade do |t|
    t.string   "name"
    t.date     "birthday"
    t.string   "gender"
    t.string   "phone"
    t.text     "address"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "user"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

  create_table "static_pages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
