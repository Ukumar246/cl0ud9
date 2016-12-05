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

ActiveRecord::Schema.define(version: 20161205023141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cloud9_people", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "permissions"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["person_id"], name: "index_cloud9_people_on_person_id", using: :btree
  end

  create_table "golf_course_people", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "golf_course_id"
    t.string   "permissions"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["golf_course_id"], name: "index_golf_course_people_on_golf_course_id", using: :btree
    t.index ["person_id"], name: "index_golf_course_people_on_person_id", using: :btree
  end

  create_table "golf_courses", force: :cascade do |t|
    t.string   "name"
    t.bigint   "phone"
    t.integer  "addrStreetNum"
    t.integer  "addrUnitNum"
    t.string   "addrStreetName"
    t.string   "addrCity"
    t.string   "addrPostalCode"
    t.string   "addrCountry"
    t.string   "logoLink"
    t.string   "websiteURL"
    t.string   "email"
    t.integer  "capacity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "hosts", force: :cascade do |t|
    t.string   "hostName"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint   "phone"
  end

  create_table "organizers", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.string   "permissions"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["person_id"], name: "index_organizers_on_person_id", using: :btree
    t.index ["tournament_id"], name: "index_organizers_on_tournament_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string   "fName"
    t.string   "lName"
    t.date     "birthDate"
    t.string   "email"
    t.boolean  "allowUserEmails"
    t.string   "pword"
    t.string   "profilePicLink"
    t.string   "twitterLink"
    t.string   "fbLink"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_people_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_people_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_people_on_unlock_token", unique: true, using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "photoLink"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.integer  "team_id"
    t.boolean  "checkedIn"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "QRCodeStr"
    t.integer  "ticket_type_id"
    t.index ["person_id"], name: "index_players_on_person_id", using: :btree
    t.index ["team_id"], name: "index_players_on_team_id", using: :btree
    t.index ["ticket_type_id"], name: "index_players_on_ticket_type_id", using: :btree
    t.index ["tournament_id"], name: "index_players_on_tournament_id", using: :btree
  end

  create_table "private_urls", force: :cascade do |t|
    t.text     "key"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["tournament_id"], name: "index_private_urls_on_tournament_id", using: :btree
  end

  create_table "scheduled_events", force: :cascade do |t|
    t.integer  "tournament_id"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "startTime"
    t.index ["tournament_id"], name: "index_scheduled_events_on_tournament_id", using: :btree
  end

  create_table "sponsors", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.string   "logoLink"
    t.string   "websiteURL"
    t.string   "twitterLink"
    t.string   "fbLink"
    t.string   "snapchatHandle"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "paid"
    t.integer  "sponsorship_id"
    t.index ["person_id"], name: "index_sponsors_on_person_id", using: :btree
    t.index ["sponsorship_id"], name: "index_sponsors_on_sponsorship_id", using: :btree
    t.index ["tournament_id"], name: "index_sponsors_on_tournament_id", using: :btree
  end

  create_table "sponsorships", force: :cascade do |t|
    t.integer  "tournament_id"
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["tournament_id"], name: "index_sponsorships_on_tournament_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "numPlayers"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "teeTime"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id", using: :btree
  end

  create_table "ticket_types", force: :cascade do |t|
    t.integer  "tournament_id"
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "numPlayers",    default: 1
    t.index ["tournament_id"], name: "index_ticket_types_on_tournament_id", using: :btree
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.text     "shortDesc"
    t.integer  "numGuests"
    t.boolean  "privateURL",     default: false
    t.string   "microSiteURL"
    t.string   "logoLink"
    t.string   "language"
    t.string   "currency"
    t.string   "timeZone"
    t.integer  "ticketsLeft"
    t.datetime "registerStart"
    t.datetime "registerEnd"
    t.integer  "host_id"
    t.integer  "golf_course_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "tournamentDate"
    t.string   "course_name"
    t.string   "course_addr"
    t.index ["golf_course_id"], name: "index_tournaments_on_golf_course_id", using: :btree
    t.index ["host_id"], name: "index_tournaments_on_host_id", using: :btree
  end

  create_table "unscheduled_events", force: :cascade do |t|
    t.integer  "tournament_id"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["tournament_id"], name: "index_unscheduled_events_on_tournament_id", using: :btree
  end

  add_foreign_key "cloud9_people", "people"
  add_foreign_key "golf_course_people", "golf_courses"
  add_foreign_key "golf_course_people", "people"
  add_foreign_key "organizers", "people"
  add_foreign_key "organizers", "tournaments"
  add_foreign_key "players", "people"
  add_foreign_key "players", "teams"
  add_foreign_key "players", "tournaments"
  add_foreign_key "private_urls", "tournaments"
  add_foreign_key "scheduled_events", "tournaments"
  add_foreign_key "sponsors", "people"
  add_foreign_key "sponsors", "tournaments"
  add_foreign_key "sponsorships", "tournaments"
  add_foreign_key "teams", "tournaments"
  add_foreign_key "ticket_types", "tournaments"
  add_foreign_key "tournaments", "golf_courses"
  add_foreign_key "tournaments", "hosts"
  add_foreign_key "unscheduled_events", "tournaments"
end
