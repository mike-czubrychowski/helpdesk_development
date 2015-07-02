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

ActiveRecord::Schema.define(version: 20150702095228) do

  create_table "assignments", force: true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["role_id"], name: "index_assignments_on_roles_id", using: :btree
  add_index "assignments", ["user_id"], name: "index_assignments_on_users_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "category",    limit: 50, null: false
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",            null: false
    t.string   "ancestry"
  end

  add_index "locations", ["ancestry"], name: "locations_ancestry", using: :btree
  add_index "locations", ["manager_id"], name: "locations_manager_id_fk", using: :btree

  create_table "organisations", force: true do |t|
    t.string   "name",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_category_id"
    t.integer  "location_id",        default: 654, null: false
  end

  create_table "people", force: true do |t|
    t.integer  "store_detail_id"
    t.date     "startdate"
    t.date     "leavedate"
    t.integer  "title"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "preferredname"
    t.string   "jobtitle"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["store_detail_id"], name: "index_people_on_store_detail_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_details", force: true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.string   "account",            limit: 3
    t.string   "status",                                        null: false
    t.date     "openingday",                                    null: false
    t.string   "address1",                                      null: false
    t.string   "address2"
    t.string   "address3"
    t.string   "town",                                          null: false
    t.string   "county"
    t.string   "postcode",                                      null: false
    t.string   "phone"
    t.string   "uk_country",                                    null: false
    t.boolean  "centreofexcellence",            default: false
    t.boolean  "superleague",                   default: false
    t.float    "latitude",           limit: 24, default: 0.0
    t.float    "longitude",          limit: 24, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_details", ["location_id"], name: "index_store_details_on_location_id", using: :btree

  create_table "store_tills", force: true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.integer  "modelname"
    t.string   "ip"
    t.integer  "comms_support"
    t.integer  "mid"
    t.integer  "ped_user"
    t.integer  "ped_pin"
    t.string   "pos_keyboard"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_tills", ["location_id"], name: "index_store_tills_on_location_id", using: :btree

  create_table "ticket_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  create_table "ticket_comments", force: true do |t|
    t.integer  "ticket_detail_id"
    t.string   "name"
    t.text     "description"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ticket_comments", ["created_by_id"], name: "index_ticket_comments_on_created_by_id", using: :btree
  add_index "ticket_comments", ["ticket_detail_id"], name: "index_ticket_comments_on_ticket_detail_id", using: :btree
  add_index "ticket_comments", ["updated_by_id"], name: "index_ticket_comments_on_updated_by_id", using: :btree

  create_table "ticket_details", force: true do |t|
    t.integer  "location_id",                       null: false
    t.integer  "parent_id"
    t.integer  "ticket_type_id",        default: 0, null: false
    t.integer  "ticket_category_id"
    t.integer  "ticket_subcategory_id"
    t.integer  "ticket_priority_id",    default: 1, null: false
    t.integer  "ticket_status_id"
    t.integer  "ticket_comment_id"
    t.string   "name",                              null: false
    t.text     "description"
    t.integer  "created_by_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_sla_id",         default: 1, null: false
  end

  add_index "ticket_details", ["created_by_id"], name: "index_ticket_details_on_created_by_id", using: :btree
  add_index "ticket_details", ["location_id"], name: "index_ticket_details_on_location_id", using: :btree
  add_index "ticket_details", ["parent_id"], name: "index_ticket_details_on_parent_id", using: :btree
  add_index "ticket_details", ["ticket_category_id"], name: "index_ticket_details_on_ticket_category_id", using: :btree
  add_index "ticket_details", ["ticket_comment_id"], name: "index_ticket_details_on_ticket_comment_id", using: :btree
  add_index "ticket_details", ["ticket_status_id"], name: "index_ticket_details_on_ticket_status_id", using: :btree
  add_index "ticket_details", ["ticket_subcategory_id"], name: "index_ticket_details_on_ticket_subcategory_id", using: :btree

  create_table "ticket_priorities", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_sla_assignments", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "ticket_category_id"
    t.integer  "ticket_priority_id"
    t.integer  "ticket_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_sla_id"
  end

  add_index "ticket_sla_assignments", ["ticket_category_id"], name: "index_ticket_slas_on_ticket_category_id", using: :btree
  add_index "ticket_sla_assignments", ["ticket_priority_id"], name: "index_ticket_slas_on_ticket_priority_id", using: :btree
  add_index "ticket_sla_assignments", ["ticket_type_id"], name: "index_ticket_slas_on_ticket_type_id", using: :btree

  create_table "ticket_slas", force: true do |t|
    t.string   "name"
    t.float    "breach",     limit: 24, default: 1.0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "warn",       limit: 24, default: 0.66667, null: false
  end

  create_table "ticket_statistics", id: false, force: true do |t|
    t.integer "location_id",                           null: false
    t.string  "ticket_priority"
    t.string  "ticket_type"
    t.integer "count(t.id)",     limit: 8, default: 0, null: false
  end

  create_table "ticket_status_histories", force: true do |t|
    t.integer  "ticket_detail_id"
    t.integer  "ticket_status_id"
    t.datetime "from",             null: false
    t.datetime "to"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ticket_status_histories", ["ticket_detail_id"], name: "index_ticket_status_histories_on_ticket_detail_id", using: :btree
  add_index "ticket_status_histories", ["ticket_status_id"], name: "index_ticket_status_histories_on_ticket_status_id", using: :btree
  add_index "ticket_status_histories", ["updated_by_id"], name: "index_ticket_status_histories_on_updated_by_id", using: :btree

  create_table "ticket_statuses", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.boolean  "time_tracked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_types", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_user_assignments", force: true do |t|
    t.integer  "ticket_detail_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ticket_user_assignments", ["ticket_detail_id"], name: "index_ticket_users_on_ticket_detail_id", using: :btree
  add_index "ticket_user_assignments", ["user_id"], name: "index_ticket_users_on_user_id", using: :btree

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "person_id"
    t.integer  "organisation_id",        default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",            default: 0,  null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "reset_password_token_UNIQUE", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "locations", "people", name: "locations_manager_id_fk", column: "manager_id"

  add_foreign_key "people", "store_details", name: "people_store_detail_id_fk"

  add_foreign_key "ticket_comments", "ticket_details", name: "ticket_comments_ticket_detail_id_fk"

  add_foreign_key "ticket_details", "locations", name: "ticket_details_location_id_fk"

end
