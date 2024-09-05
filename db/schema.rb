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

ActiveRecord::Schema[7.0].define(version: 2024_09_05_224552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "admin_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admin_profiles_on_user_id"
  end

  create_table "brps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "company_id", null: false
    t.date "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_brps_on_company_id"
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "nit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "executive_profile_id", null: false
    t.index ["executive_profile_id"], name: "index_companies_on_executive_profile_id"
    t.index ["nit"], name: "index_companies_on_nit", unique: true
  end

  create_table "employee_personal_infos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "employee_profile_id", null: false
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

  create_table "employee_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "company_id"
    t.uuid "form_type_id"
    t.index ["company_id"], name: "index_employee_profiles_on_company_id"
    t.index ["form_type_id"], name: "index_employee_profiles_on_form_type_id"
    t.index ["user_id"], name: "index_employee_profiles_on_user_id"
  end

  create_table "employee_work_infos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "employee_profile_id", null: false
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

  create_table "executive_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "full_name"
    t.string "nit"
    t.string "professional_card"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_executive_profiles_on_user_id"
  end

  create_table "form_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_denylists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti", unique: true
  end

  create_table "questionnaires", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "abbreviation"
  end

  create_table "questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "questionnaire_id", null: false
    t.uuid "form_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.index ["form_type_id"], name: "index_questions_on_form_type_id"
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "responses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "brp_id", null: false
    t.uuid "question_id", null: false
    t.uuid "employee_profile_id", null: false
    t.text "answer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brp_id"], name: "index_responses_on_brp_id"
    t.index ["employee_profile_id"], name: "index_responses_on_employee_profile_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
  add_foreign_key "brps", "companies"
  add_foreign_key "companies", "executive_profiles"
  add_foreign_key "employee_personal_infos", "employee_profiles"
  add_foreign_key "employee_profiles", "companies"
  add_foreign_key "employee_profiles", "form_types"
  add_foreign_key "employee_profiles", "users"
  add_foreign_key "employee_work_infos", "employee_profiles"
  add_foreign_key "executive_profiles", "users"
  add_foreign_key "questions", "form_types"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "responses", "brps"
  add_foreign_key "responses", "employee_profiles"
  add_foreign_key "responses", "questions"
end
