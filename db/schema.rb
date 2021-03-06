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

ActiveRecord::Schema.define(version: 20140811151556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "type"
    t.integer  "actor_id"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "metadata",     default: "--- {}\n"
  end

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
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wow_auction_snapshots", force: true do |t|
    t.integer  "auction_id"
    t.string   "time_left"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bid",           limit: 8
    t.integer  "realm_sync_id"
  end

  add_index "wow_auction_snapshots", ["auction_id"], name: "index_wow_auction_snapshots_on_auction_id", using: :btree
  add_index "wow_auction_snapshots", ["realm_sync_id"], name: "index_wow_auction_snapshots_on_realm_sync_id", using: :btree

  create_table "wow_auctions", force: true do |t|
    t.integer  "realm_id"
    t.string   "auction_house"
    t.integer  "blizz_item_id"
    t.string   "owner"
    t.string   "owner_realm"
    t.integer  "quantity"
    t.integer  "rand"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "auc",              limit: 8
    t.integer  "buyout",           limit: 8
    t.integer  "seed",             limit: 8
    t.string   "status",                     default: "in_progress"
    t.integer  "item_id"
    t.integer  "last_snapshot_id"
  end

  add_index "wow_auctions", ["auc"], name: "index_wow_auctions_on_auc", using: :btree
  add_index "wow_auctions", ["blizz_item_id"], name: "index_wow_auctions_on_blizz_item_id", using: :btree
  add_index "wow_auctions", ["item_id"], name: "index_wow_auctions_on_item_id", using: :btree
  add_index "wow_auctions", ["last_snapshot_id"], name: "index_wow_auctions_on_last_snapshot_id", using: :btree
  add_index "wow_auctions", ["owner", "owner_realm"], name: "index_wow_auctions_on_owner_and_owner_realm", using: :btree
  add_index "wow_auctions", ["realm_id"], name: "index_wow_auctions_on_realm_id", using: :btree
  add_index "wow_auctions", ["status"], name: "index_wow_auctions_on_status", using: :btree

  create_table "wow_items", force: true do |t|
    t.integer  "blizz_item_id"
    t.string   "name"
    t.string   "description"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wow_items", ["blizz_item_id"], name: "index_wow_items_on_blizz_item_id", unique: true, using: :btree

  create_table "wow_realm_syncs", force: true do |t|
    t.integer  "realm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wow_realm_syncs", ["created_at"], name: "index_wow_realm_syncs_on_created_at", using: :btree
  add_index "wow_realm_syncs", ["realm_id"], name: "index_wow_realm_syncs_on_realm_id", using: :btree

  create_table "wow_realms", force: true do |t|
    t.string   "slug"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "polling_enabled", default: false
    t.datetime "last_checked_at"
    t.datetime "last_synced_at"
  end

  add_index "wow_realms", ["polling_enabled"], name: "index_wow_realms_on_polling_enabled", using: :btree

  create_table "wow_toons", force: true do |t|
    t.integer  "user_id"
    t.integer  "realm_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wow_toons", ["realm_id"], name: "index_wow_toons_on_realm_id", using: :btree
  add_index "wow_toons", ["user_id"], name: "index_wow_toons_on_user_id", using: :btree

  add_foreign_key "wow_auction_snapshots", "wow_auctions", name: "wow_auction_snapshots_auction_id_fk", column: "auction_id"
  add_foreign_key "wow_auction_snapshots", "wow_realm_syncs", name: "wow_auction_snapshots_realm_sync_id_fk", column: "realm_sync_id"

  add_foreign_key "wow_auctions", "wow_auction_snapshots", name: "wow_auctions_last_snapshot_id_fk", column: "last_snapshot_id"
  add_foreign_key "wow_auctions", "wow_items", name: "wow_auctions_item_id_fk", column: "item_id"
  add_foreign_key "wow_auctions", "wow_realms", name: "wow_auctions_realm_id_fk", column: "realm_id"

  add_foreign_key "wow_realm_syncs", "wow_realms", name: "wow_realm_syncs_realm_id_fk", column: "realm_id"

  add_foreign_key "wow_toons", "users", name: "wow_toons_user_id_fk"
  add_foreign_key "wow_toons", "wow_realms", name: "wow_toons_realm_id_fk", column: "realm_id"

end
