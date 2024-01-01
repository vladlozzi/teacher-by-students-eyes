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

ActiveRecord::Schema[7.0].define(version: 2023_12_19_091808) do
  create_table "criteria", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "scale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_criteria_on_name", unique: true
  end

  create_table "groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "group", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group"], name: "index_groups_on_group", unique: true
  end

  create_table "people", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "orcid"
    t.string "scopus_authorid"
    t.string "wos_researcherid"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["full_name"], name: "index_people_on_full_name", unique: true
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role"], name: "index_roles_on_role", unique: true
  end

  create_table "student_distributions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "group_id", null: false
    t.integer "edebo_study_code"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["edebo_study_code"], name: "index_student_distributions_on_edebo_study_code", unique: true
    t.index ["email"], name: "index_student_distributions_on_email", unique: true
    t.index ["group_id"], name: "index_student_distributions_on_group_id"
    t.index ["student_id"], name: "index_student_distributions_on_student_id"
  end

  create_table "student_teachers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "student_distribution_id", null: false
    t.bigint "teacher_distribution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_distribution_id"], name: "index_student_teachers_on_student_distribution_id"
    t.index ["teacher_distribution_id"], name: "index_student_teachers_on_teacher_distribution_id"
  end

  create_table "students", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "edebo_person_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["edebo_person_code"], name: "index_students_on_edebo_person_code", unique: true
  end

  create_table "teacher_distributions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_teacher_distributions_on_person_id"
    t.index ["unit_id"], name: "index_teacher_distributions_on_unit_id"
  end

  create_table "units", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "unit_type", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_units_on_name", unique: true
  end

  add_foreign_key "student_distributions", "groups"
  add_foreign_key "student_distributions", "students"
  add_foreign_key "student_teachers", "student_distributions"
  add_foreign_key "student_teachers", "teacher_distributions"
  add_foreign_key "teacher_distributions", "people"
  add_foreign_key "teacher_distributions", "units"
end
