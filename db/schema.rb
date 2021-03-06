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

ActiveRecord::Schema.define(version: 20151221105823) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "text",         limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "user_id",      limit: 4
    t.boolean  "published",                  default: false
    t.datetime "published_at"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "articles_categories", id: false, force: :cascade do |t|
    t.integer "article_id",  limit: 4
    t.integer "category_id", limit: 4
  end

  add_index "articles_categories", ["article_id", "category_id"], name: "index_articles_categories_on_article_id_and_category_id", unique: true, using: :btree
  add_index "articles_categories", ["article_id"], name: "article_id", using: :btree
  add_index "articles_categories", ["category_id"], name: "category_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "cat_name",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.string   "commenter",  limit: 255,   null: false
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "request_scores", force: :cascade do |t|
    t.string   "ip",            limit: 255
    t.integer  "request_count", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "request_scores", ["ip"], name: "index_request_scores_on_ip", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "password_digest",   limit: 255
    t.string   "remember_digest",   limit: 255
    t.boolean  "admin",                         default: false
    t.string   "activation_digest", limit: 255
    t.boolean  "activated",                     default: false
    t.datetime "activated_at"
    t.string   "reset_digest",      limit: 255
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

  add_foreign_key "articles", "users"
  add_foreign_key "articles_categories", "articles", name: "fk-article"
  add_foreign_key "articles_categories", "categories", name: "fk-category"
  add_foreign_key "comments", "articles"
end
