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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130405165755) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "attraction_translations", :force => true do |t|
    t.integer  "attraction_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.text     "seo_meta"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "attraction_translations", ["attraction_id"], :name => "index_attraction_translations_on_attraction_id"
  add_index "attraction_translations", ["locale"], :name => "index_attraction_translations_on_locale"

  create_table "attractions", :force => true do |t|
    t.integer  "region_id"
    t.integer  "gallery_id"
    t.string   "name"
    t.text     "description"
    t.text     "seo_meta"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "attractions", ["slug"], :name => "index_attractions_on_slug", :unique => true

  create_table "continent_translations", :force => true do |t|
    t.integer  "continent_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.text     "seo_meta"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "continent_translations", ["continent_id"], :name => "index_continent_translations_on_continent_id"
  add_index "continent_translations", ["locale"], :name => "index_continent_translations_on_locale"

  create_table "continents", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "seo_meta"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "continents", ["slug"], :name => "index_continents_on_slug", :unique => true

  create_table "countries", :force => true do |t|
    t.integer  "continent_id"
    t.string   "name"
    t.text     "kitchen"
    t.text     "description"
    t.text     "recomendation"
    t.text     "seo_meta"
    t.text     "climate"
    t.text     "culture"
    t.text     "infrastructure"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "slug"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "countries", ["slug"], :name => "index_countries_on_slug", :unique => true

  create_table "country_translations", :force => true do |t|
    t.integer  "country_id"
    t.string   "locale"
    t.string   "name"
    t.text     "kitchen"
    t.text     "climate"
    t.text     "culture"
    t.text     "description"
    t.text     "recomendation"
    t.text     "infrastructure"
    t.text     "seo_meta"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "country_translations", ["country_id"], :name => "index_country_translations_on_country_id"
  add_index "country_translations", ["locale"], :name => "index_country_translations_on_locale"

  create_table "galleries", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "galleries", ["slug"], :name => "index_galleries_on_slug", :unique => true

  create_table "gallery_translations", :force => true do |t|
    t.integer  "gallery_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "gallery_translations", ["gallery_id"], :name => "index_gallery_translations_on_gallery_id"
  add_index "gallery_translations", ["locale"], :name => "index_gallery_translations_on_locale"

  create_table "hotel_translations", :force => true do |t|
    t.integer  "hotel_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.text     "amenities"
    t.text     "policies"
    t.text     "seo_meta"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "hotel_translations", ["hotel_id"], :name => "index_hotel_translations_on_hotel_id"
  add_index "hotel_translations", ["locale"], :name => "index_hotel_translations_on_locale"

  create_table "hotels", :force => true do |t|
    t.integer  "region_id"
    t.integer  "gallery_id"
    t.integer  "star"
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "site"
    t.text     "description"
    t.text     "amenities"
    t.text     "policies"
    t.text     "seo_meta"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "hotels", ["slug"], :name => "index_hotels_on_slug", :unique => true

  create_table "photo_translations", :force => true do |t|
    t.integer  "photo_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "photo_translations", ["locale"], :name => "index_photo_translations_on_locale"
  add_index "photo_translations", ["photo_id"], :name => "index_photo_translations_on_photo_id"

  create_table "photos", :force => true do |t|
    t.integer  "gallery_id"
    t.string   "title"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "region_translations", :force => true do |t|
    t.integer  "region_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.text     "seo_meta"
    t.text     "recomendation"
    t.text     "infrastructure"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "region_translations", ["locale"], :name => "index_region_translations_on_locale"
  add_index "region_translations", ["region_id"], :name => "index_region_translations_on_region_id"

  create_table "regions", :force => true do |t|
    t.integer  "country_id"
    t.integer  "gallery_id"
    t.string   "name"
    t.text     "description"
    t.text     "seo_meta"
    t.text     "recomendation"
    t.text     "infrastructure"
    t.string   "slug"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "regions", ["slug"], :name => "index_regions_on_slug", :unique => true

  create_table "visa_translations", :force => true do |t|
    t.integer  "visa_id"
    t.string   "locale"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "visa_translations", ["locale"], :name => "index_visa_translations_on_locale"
  add_index "visa_translations", ["visa_id"], :name => "index_visa_translations_on_visa_id"

  create_table "visa_type_translations", :force => true do |t|
    t.integer  "visa_type_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "visa_type_translations", ["locale"], :name => "index_visa_type_translations_on_locale"
  add_index "visa_type_translations", ["visa_type_id"], :name => "index_visa_type_translations_on_visa_type_id"

  create_table "visa_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "visas", :force => true do |t|
    t.integer  "country_id"
    t.integer  "visa_type_id"
    t.text     "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
