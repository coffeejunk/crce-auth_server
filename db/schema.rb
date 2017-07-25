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

ActiveRecord::Schema.define(version: 20170705102522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "administrative_accounts", id: :serial, force: :cascade do |t|
    t.string "public_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["public_key"], name: "index_administrative_accounts_on_public_key", unique: true
  end

  create_table "api_consumers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "envelope_communities", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "default", default: false, null: false
    t.string "backup_item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_envelope_communities_on_name", unique: true
  end

  create_table "envelope_transactions", id: :serial, force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "envelope_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "envelopes", id: :serial, force: :cascade do |t|
    t.integer "envelope_type", default: 0, null: false
    t.string "envelope_version", null: false
    t.string "envelope_id", null: false
    t.text "resource", null: false
    t.integer "resource_format", default: 0, null: false
    t.integer "resource_encoding", default: 0, null: false
    t.text "resource_public_key", null: false
    t.text "node_headers"
    t.integer "node_headers_format", default: 0
    t.jsonb "processed_resource", default: {}, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "envelope_community_id", null: false
    t.text "fts_tsearch"
    t.text "fts_trigram"
    t.tsvector "fts_tsearch_tsv"
    t.string "resource_type"
    t.index "((processed_resource ->> '@id'::text))", name: "envelopes_resources_id_idx"
    t.index "fts_trigram gin_trgm_ops", name: "envelopes_fts_trigram_idx", using: :gin
    t.index ["envelope_id"], name: "index_envelopes_on_envelope_id", unique: true
    t.index ["envelope_type"], name: "index_envelopes_on_envelope_type"
    t.index ["envelope_version"], name: "index_envelopes_on_envelope_version"
    t.index ["fts_tsearch_tsv"], name: "index_envelopes_on_fts_tsearch_tsv", using: :gin
    t.index ["processed_resource"], name: "index_envelopes_on_processed_resource", using: :gin
  end

  create_table "json_schemas", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "schema", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_json_schemas_on_name"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object", default: {}
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["object"], name: "index_versions_on_object", using: :gin
  end

  add_foreign_key "envelope_transactions", "envelopes"
  add_foreign_key "envelopes", "envelope_communities"
end
