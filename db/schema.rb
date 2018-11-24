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

ActiveRecord::Schema.define(version: 20160118043847) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.integer  "balance"
    t.decimal  "daily_percentage_rate"
    t.decimal  "weekly_percentage_rate"
    t.decimal  "annual_percentage_rate"
  end

  create_table "interest_accruals", force: :cascade do |t|
    t.integer  "account_id"
    t.date     "accrued_on"
    t.integer  "amount"
    t.integer  "account_end_balance"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.boolean  "applied"
    t.datetime "applied_at"
  end

  create_table "journals", force: :cascade do |t|
    t.string   "transaction_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "notes"
  end

  create_table "postings", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "journal_id"
    t.integer  "amount"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "start_balance"
    t.integer  "end_balance"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "system_accounts", force: :cascade do |t|
    t.string   "name"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "transaction_type"
    t.integer  "account_id"
    t.integer  "amount"
    t.integer  "journal_id"
    t.string   "note"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "start_balance"
    t.integer  "end_balance"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

end
