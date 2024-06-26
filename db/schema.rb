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

ActiveRecord::Schema[7.1].define(version: 2024_05_05_234712) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "earnings", force: :cascade do |t|
    t.datetime "earning_date"
    t.integer "amount_cents"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_earnings_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.bigint "employer_id", null: false
    t.string "external_ref"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employees_on_employer_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "layouts", force: :cascade do |t|
    t.bigint "employer_id", null: false
    t.string "ext_ref_num_label"
    t.string "amount_label"
    t.string "earning_date_format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "earning_date_label"
    t.index ["employer_id"], name: "index_layouts_on_employer_id"
  end

  add_foreign_key "earnings", "employees"
  add_foreign_key "employees", "employers"
  add_foreign_key "layouts", "employers"
end
