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

ActiveRecord::Schema[7.0].define(version: 2024_09_03_071842) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admin_profiles_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "nit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "executive_profile_id", null: false
    t.index ["executive_profile_id"], name: "index_companies_on_executive_profile_id"
    t.index ["nit"], name: "index_companies_on_nit", unique: true
  end

  create_table "employee_personal_infos", force: :cascade do |t|
    t.bigint "employee_profile_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "document_id"
    t.string "gender"
    t.date "birthdate"
    t.string "civil_status"
    t.string "level_education"
    t.string "socioeconomic_status"
    t.string "living_place"
    t.string "people_dependents"
    t.string "residence_state"
    t.string "residence_city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_profile_id"], name: "index_employee_personal_infos_on_employee_profile_id"
  end

  create_table "employee_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_employee_profiles_on_user_id"
  end

  create_table "employee_work_infos", force: :cascade do |t|
    t.bigint "employee_profile_id", null: false
    t.string "work_city"
    t.string "work_state"
    t.string "seniority_company"
    t.string "seniority_office"
    t.string "position_held"
    t.string "work_area"
    t.string "contract_type"
    t.string "working_hours_per_day"
    t.string "salary_type"
    t.string "occupation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_profile_id"], name: "index_employee_work_infos_on_employee_profile_id"
  end

  create_table "executive_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "full_name"
    t.string "nit"
    t.string "professional_card"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_executive_profiles_on_user_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "admin_profiles", "users"
  add_foreign_key "companies", "executive_profiles"
  add_foreign_key "employee_personal_infos", "employee_profiles"
  add_foreign_key "employee_profiles", "users"
  add_foreign_key "employee_work_infos", "employee_profiles"
  add_foreign_key "executive_profiles", "users"
end
