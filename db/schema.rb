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

ActiveRecord::Schema.define(version: 20151022005709) do

  create_table "annotations", force: :cascade do |t|
    t.integer  "species_id",      limit: 4
    t.string   "name",            limit: 255
    t.string   "MPG_name",        limit: 255
    t.string   "MPG_description", limit: 255
    t.string   "Goterm",          limit: 1000
    t.string   "UnitProt",        limit: 10000
    t.string   "InterPro",        limit: 10000
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "annotations", ["species_id"], name: "fk_rails_96a873a473", using: :btree

  create_table "families", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "species", force: :cascade do |t|
    t.integer  "family_id",   limit: 4
    t.string   "name",        limit: 255
    t.string   "image",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "species", ["family_id"], name: "fk_rails_0b6166e342", using: :btree

  create_table "ssrs", force: :cascade do |t|
    t.integer  "species_id",     limit: 4
    t.string   "SSR_ID",         limit: 255
    t.integer  "SSR_nr",         limit: 4
    t.string   "SSR_type",       limit: 255
    t.string   "SSR",            limit: 1000
    t.integer  "size",           limit: 4
    t.integer  "start",          limit: 4
    t.integer  "end",            limit: 4
    t.string   "Forward1",       limit: 255
    t.string   "Reverse1",       limit: 255
    t.float    "FP_Tm1",         limit: 24
    t.integer  "FP_Size1",       limit: 4
    t.float    "RP_Tm1",         limit: 24
    t.integer  "RP_Size1",       limit: 4
    t.integer  "Product_Size1",  limit: 4
    t.integer  "Start1",         limit: 4
    t.integer  "End1",           limit: 4
    t.string   "Forward2",       limit: 255
    t.string   "Reverse2",       limit: 255
    t.float    "FP_Tm2",         limit: 24
    t.integer  "FP_Size2",       limit: 4
    t.float    "RP_Tm2",         limit: 24
    t.integer  "RP_Size2",       limit: 4
    t.integer  "Product_Size2",  limit: 4
    t.integer  "Start2",         limit: 4
    t.integer  "End2",           limit: 4
    t.string   "Forward3",       limit: 255
    t.string   "Reverse3",       limit: 255
    t.float    "FP_Tm3",         limit: 24
    t.integer  "FP_Size3",       limit: 4
    t.float    "RP_Tm3",         limit: 24
    t.integer  "RP_Size3",       limit: 4
    t.integer  "Product_Size3",  limit: 4
    t.integer  "Start3",         limit: 4
    t.integer  "End3",           limit: 4
    t.boolean  "has_annotation"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "ssrs", ["species_id"], name: "fk_rails_824acfb1c3", using: :btree

  create_table "statistics", force: :cascade do |t|
    t.integer  "species_id",      limit: 4
    t.integer  "Num_Seqs_Exam",   limit: 4
    t.integer  "Size_Exam_Seqs",  limit: 4
    t.integer  "Num_SSR_Indent",  limit: 4
    t.integer  "SSR_Cont_Seqs",   limit: 4
    t.integer  "Seqs_Cont_SSR",   limit: 4
    t.integer  "Num_SSR_Present", limit: 4
    t.integer  "Mono",            limit: 4
    t.integer  "Di",              limit: 4
    t.integer  "Tri",             limit: 4
    t.integer  "Tetra",           limit: 4
    t.integer  "Penta",           limit: 4
    t.integer  "Hexa",            limit: 4
    t.integer  "Complex",         limit: 4
    t.integer  "Compound",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "statistics", ["species_id"], name: "fk_rails_d6c97f02d7", using: :btree

  add_foreign_key "annotations", "species"
  add_foreign_key "species", "families"
  add_foreign_key "ssrs", "species"
  add_foreign_key "statistics", "species"
end
