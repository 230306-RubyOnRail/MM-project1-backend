# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_07_154207) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reimbursements", force: :cascade do |t|
    t.string "description"
    t.string "status"
    t.float "amount"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reimbursements_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "shorten_url", id: :integer, default: nil, force: :cascade do |t|
    t.string "code", limit: 10, null: false
    t.string "short_url", null: false
    t.string "orig_url", null: false
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at"
    t.index ["code"], name: "shorten_url_code_key", unique: true
    t.index ["short_url"], name: "shorten_url_short_url_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "reimbursements", "users"
  add_foreign_key "users", "roles"
end
