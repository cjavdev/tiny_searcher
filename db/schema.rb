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

ActiveRecord::Schema.define(version: 2019_03_03_221456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domains", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "name"], name: "index_domains_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_domains_on_organization_id"
  end

  create_table "organization_domains", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organization_domains_on_name"
    t.index ["organization_id", "name"], name: "index_organization_domains_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_organization_domains_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.string "details"
    t.boolean "shared_tickets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_organizations_on_external_id"
    t.index ["name"], name: "index_organizations_on_name"
    t.index ["shared_tickets"], name: "index_organizations_on_shared_tickets"
  end

  create_table "tags", force: :cascade do |t|
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["taggable_id", "taggable_type", "name"], name: "index_tags_on_taggable_id_and_taggable_type_and_name", unique: true
    t.index ["taggable_type", "taggable_id"], name: "index_tags_on_taggable_type_and_taggable_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "external_id"
    t.string "ticket_type"
    t.string "subject"
    t.text "description"
    t.string "priority"
    t.string "status"
    t.integer "submitter_id"
    t.integer "assignee_id"
    t.bigint "organization_id"
    t.boolean "has_incidents"
    t.datetime "due_at"
    t.string "via"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tickets_on_assignee_id"
    t.index ["external_id"], name: "index_tickets_on_external_id"
    t.index ["organization_id"], name: "index_tickets_on_organization_id"
    t.index ["priority"], name: "index_tickets_on_priority"
    t.index ["status"], name: "index_tickets_on_status"
    t.index ["submitter_id"], name: "index_tickets_on_submitter_id"
    t.index ["ticket_type"], name: "index_tickets_on_ticket_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.string "alias"
    t.boolean "active"
    t.boolean "verified"
    t.boolean "shared"
    t.string "locale"
    t.string "timezone"
    t.datetime "last_login_at"
    t.string "email"
    t.string "phone"
    t.string "signature"
    t.bigint "organization_id"
    t.boolean "suspended"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  add_foreign_key "domains", "organizations"
  add_foreign_key "organization_domains", "organizations"
  add_foreign_key "tickets", "organizations"
  add_foreign_key "users", "organizations"
end
