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

ActiveRecord::Schema.define(version: 20161231103347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "families", force: :cascade do |t|
    t.string   "name",        :null=>false
    t.string   "description"
    t.integer  "major_group", :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genera", force: :cascade do |t|
    t.string   "name",        :null=>false
    t.string   "description"
    t.boolean  "hybrid",      :default=>false, :null=>false
    t.integer  "family_id",   :null=>false, :foreign_key=>{:references=>"families", :name=>"fk_genera_family_id", :on_update=>:no_action, :on_delete=>:no_action}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "imageable_type", :null=>false
    t.integer  "imageable_id",   :null=>false
    t.string   "photo",          :null=>false
    t.datetime "deleted_at",     :index=>{:name=>"index_photos_on_deleted_at", :using=>:btree}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "species", force: :cascade do |t|
    t.string   "name",                  :null=>false
    t.string   "common_name"
    t.string   "description"
    t.string   "authorship"
    t.string   "source"
    t.string   "source_id"
    t.string   "combined_source_id"
    t.string   "ipni_id"
    t.string   "publication"
    t.string   "collation"
    t.integer  "date"
    t.string   "infraspecific_rank"
    t.string   "infraspecific_epithet"
    t.integer  "taxonomic_status",      :null=>false
    t.integer  "confidence_level"
    t.boolean  "hybrid",                :default=>false, :null=>false
    t.integer  "genus_id",              :null=>false, :foreign_key=>{:references=>"genera", :name=>"fk_species_genus_id", :on_update=>:no_action, :on_delete=>:no_action}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plants", force: :cascade do |t|
    t.integer  "species_id", :null=>false, :foreign_key=>{:references=>"species", :name=>"fk_plants_species_id", :on_update=>:no_action, :on_delete=>:no_action}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",      :null=>false
    t.string   "google_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
