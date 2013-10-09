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

ActiveRecord::Schema.define(version: 20131009080955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_chats", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "admin_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_chats", ["admin_id"], name: "index_active_chats_on_admin_id", using: :btree
  add_index "active_chats", ["user_id", "admin_id"], name: "index_active_chats_on_user_id_and_admin_id", unique: true, using: :btree
  add_index "active_chats", ["user_id"], name: "index_active_chats_on_user_id", using: :btree

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, using: :btree

  create_table "assets", force: true do |t|
    t.integer  "project_id",     null: false
    t.string   "title"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filepicker_url"
  end

  add_index "assets", ["project_id"], name: "index_assets_on_project_id", using: :btree

  create_table "messages", force: true do |t|
    t.text     "body",                       null: false
    t.integer  "user_id",                    null: false
    t.boolean  "bookmark",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
  end

  add_index "messages", ["admin_id"], name: "index_messages_on_admin_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "orders", force: true do |t|
    t.string   "order_type"
    t.integer  "project_id",                                                    null: false
    t.string   "state",                                   default: "submitted", null: false
    t.string   "title",                                                         null: false
    t.text     "description"
    t.decimal  "price",           precision: 8, scale: 2
    t.string   "carrier"
    t.string   "tracking_number"
    t.string   "confirmation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["project_id"], name: "index_orders_on_project_id", using: :btree

  create_table "orders_project_files", id: false, force: true do |t|
    t.integer "order_id"
    t.integer "project_file_id"
  end

  add_index "orders_project_files", ["order_id", "project_file_id"], name: "index_orders_project_files_on_order_id_and_project_file_id", using: :btree
  add_index "orders_project_files", ["order_id"], name: "index_orders_project_files_on_order_id", using: :btree
  add_index "orders_project_files", ["project_file_id"], name: "index_orders_project_files_on_project_file_id", using: :btree

  create_table "orders_shippable_files", id: false, force: true do |t|
    t.integer "order_id"
    t.integer "project_file_id"
  end

  add_index "orders_shippable_files", ["order_id", "project_file_id"], name: "index_orders_shippable_files_on_order_id_and_project_file_id", unique: true, using: :btree
  add_index "orders_shippable_files", ["order_id"], name: "index_orders_shippable_files_on_order_id", using: :btree
  add_index "orders_shippable_files", ["project_file_id"], name: "index_orders_shippable_files_on_project_file_id", using: :btree

  create_table "project_files", force: true do |t|
    t.integer  "project_id", null: false
    t.string   "url",        null: false
    t.string   "filename",   null: false
    t.integer  "size",       null: false
    t.string   "mimetype",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_files", ["project_id"], name: "index_project_files_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "title",      default: "New Project", null: false
    t.integer  "user_id",                            null: false
    t.text     "spec"
    t.date     "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
