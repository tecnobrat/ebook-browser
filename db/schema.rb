# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100128022452) do

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.string   "uuid",       :limit => 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.integer  "publisher_id"
    t.integer  "author_id"
    t.integer  "series_id"
    t.string   "uuid",            :limit => 36
    t.string   "title"
    t.integer  "isbn",            :limit => 8
    t.integer  "file_size",       :limit => 8
    t.string   "file_name"
    t.string   "cover_file_name"
    t.string   "language"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books_tags", :id => false, :force => true do |t|
    t.integer  "book_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishers", :force => true do |t|
    t.string   "name"
    t.string   "uuid",       :limit => 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", :force => true do |t|
    t.string   "name"
    t.string   "uuid",       :limit => 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "uuid",       :limit => 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
