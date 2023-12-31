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

ActiveRecord::Schema[7.0].define(version: 2023_09_08_181937) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.bigint "user_id", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.text "name"
    t.text "desc"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "imagelines", force: :cascade do |t|
    t.bigint "image_id", null: false
    t.bigint "line_id", null: false
    t.bigint "user_id", null: false
    t.boolean "done"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_imagelines_on_image_id"
    t.index ["line_id"], name: "index_imagelines_on_line_id"
    t.index ["user_id"], name: "index_imagelines_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.bigint "upload_id", null: false
    t.string "title"
    t.text "desc"
    t.boolean "active"
    t.boolean "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_images_on_game_id"
    t.index ["upload_id"], name: "index_images_on_upload_id"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "lexicons", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "word"
    t.boolean "active"
    t.string "wordhu"
    t.string "lang"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lexicons_on_user_id"
  end

  create_table "lines", force: :cascade do |t|
    t.string "contentuid"
    t.string "version"
    t.text "content"
    t.integer "linieref"
    t.integer "datatype"
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.integer "lang"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "oke", default: false
    t.text "oldcontent"
    t.bigint "upload_id"
    t.index ["contentuid"], name: "index_lines_on_contentuid"
    t.index ["datatype"], name: "index_lines_on_datatype"
    t.index ["game_id"], name: "index_lines_on_game_id"
    t.index ["upload_id"], name: "index_lines_on_upload_id"
    t.index ["user_id"], name: "index_lines_on_user_id"
    t.index ["version"], name: "index_lines_on_version"
  end

  create_table "logolas", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "page"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logolas_on_user_id"
  end

  create_table "uploads", force: :cascade do |t|
    t.string "version"
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.integer "uploadtype"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lang"
    t.boolean "readxml", default: false
    t.boolean "selected", default: false
    t.index ["game_id"], name: "index_uploads_on_game_id"
    t.index ["user_id"], name: "index_uploads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "usertype"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "selected", default: 0
    t.boolean "admin", default: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blogs", "users"
  add_foreign_key "imagelines", "images"
  add_foreign_key "imagelines", "lines"
  add_foreign_key "imagelines", "users"
  add_foreign_key "images", "games"
  add_foreign_key "images", "uploads"
  add_foreign_key "images", "users"
  add_foreign_key "lexicons", "users"
  add_foreign_key "lines", "games"
  add_foreign_key "lines", "uploads"
  add_foreign_key "logolas", "users"
  add_foreign_key "uploads", "games"
end
