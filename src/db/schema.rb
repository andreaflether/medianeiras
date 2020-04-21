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

ActiveRecord::Schema.define(version: 2020_04_21_010740) do

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "location"
    t.time "starts_at"
    t.time "ends_at"
    t.integer "max_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities_students", id: false, force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "student_id", null: false
  end

  create_table "activities_volunteers", id: false, force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "volunteer_id", null: false
  end

  create_table "activities_week_days", id: false, force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "week_day_id", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.date "birthday"
    t.string "address"
    t.string "neighborhood"
    t.string "religion"
    t.string "rg"
    t.date "start_date"
    t.date "exit_date"
    t.string "citizenship"
    t.string "civil_status"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promulher_forms", force: :cascade do |t|
    t.integer "family_size"
    t.integer "f_children"
    t.integer "m_children"
    t.string "works"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "current_grade"
    t.string "school"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_students_on_person_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.text "parents"
    t.text "children"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "email"
    t.string "speciality"
    t.string "cpf"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_volunteers_on_person_id"
  end

  create_table "week_days", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
