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

ActiveRecord::Schema.define(:version => 20160614204711) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.string   "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "match_demos", :force => true do |t|
    t.integer "match_id", :null => false
    t.integer "user_id",  :null => false
    t.string  "demo",     :null => false
  end

  add_index "match_demos", ["match_id", "demo"], :name => "index_match_demos_on_match_id_and_demo"

  create_table "match_screenshots", :force => true do |t|
    t.integer "match_id", :null => false
    t.integer "user_id",  :null => false
    t.string  "image",    :null => false
  end

  add_index "match_screenshots", ["match_id", "image"], :name => "index_match_screenshots_on_match_id_and_image"

  create_table "matches", :force => true do |t|
    t.integer  "home_team_id",                              :null => false
    t.integer  "away_team_id",                              :null => false
    t.integer  "week_num",                                  :null => false
    t.datetime "match_date",                                :null => false
    t.integer  "home_points",            :default => 0
    t.integer  "away_points",            :default => 0
    t.integer  "winner_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "tournament_id",                             :null => false
    t.integer  "challonge_id",           :default => 0
    t.boolean  "challonge_updated",      :default => false
    t.string   "map_name"
    t.integer  "home_team_round_one",    :default => 0,     :null => false
    t.integer  "home_team_round_two",    :default => 0,     :null => false
    t.integer  "home_team_round_three"
    t.integer  "away_team_round_one",    :default => 0,     :null => false
    t.integer  "away_team_round_two",    :default => 0,     :null => false
    t.integer  "away_team_round_three"
    t.float    "home_team_differential", :default => 0.0,   :null => false
    t.float    "away_team_differential", :default => 0.0,   :null => false
    t.integer  "reported_by"
    t.integer  "disputed_by"
    t.boolean  "is_draw",                :default => false
    t.boolean  "is_bye",                 :default => false, :null => false
  end

  add_index "matches", ["away_team_id"], :name => "index_matches_on_away_team_id"
  add_index "matches", ["home_team_id"], :name => "index_matches_on_home_team_id"
  add_index "matches", ["tournament_id"], :name => "index_matches_on_tournament_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "team_id",                          :null => false
    t.string   "role",       :default => "member", :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "active",     :default => false,    :null => false
  end

  add_index "memberships", ["team_id"], :name => "index_memberships_on_team_id"
  add_index "memberships", ["user_id", "team_id"], :name => "index_memberships_on_user_id_and_team_id", :unique => true
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "news", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.string   "headline"
    t.string   "description"
    t.text     "content"
    t.integer  "newsable_id"
    t.string   "newsable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name",                               :null => false
    t.string   "tag",                                :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "primary_contact"
    t.string   "secondary_contact",  :default => ""
    t.string   "website",            :default => ""
    t.string   "irc_channel"
    t.string   "voip",               :default => ""
    t.string   "youtube_channel",    :default => ""
    t.string   "twitch_channel",     :default => ""
    t.string   "featured_video",     :default => ""
    t.text     "description",        :default => ""
    t.string   "gravatar_email",     :default => "", :null => false
    t.string   "join_password_hash", :default => ""
    t.string   "join_password_salt", :default => ""
  end

  create_table "tournament_admins", :force => true do |t|
    t.integer  "tournament_id", :default => 0, :null => false
    t.integer  "user_id",       :default => 0, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "tournament_admins", ["tournament_id", "user_id"], :name => "index_tournament_admins_on_tournament_id_and_user_id", :unique => true

  create_table "tournament_team_memberships", :force => true do |t|
    t.integer  "tournament_id",      :null => false
    t.integer  "tournament_team_id", :null => false
    t.integer  "user_id",            :null => false
    t.string   "authorization_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "tournament_team_memberships", ["tournament_id", "user_id"], :name => "index_tournament_team_memberships_on_tournament_id_and_user_id", :unique => true
  add_index "tournament_team_memberships", ["tournament_team_id"], :name => "index_tournament_team_memberships_on_tournament_team_id"

  create_table "tournament_teams", :force => true do |t|
    t.integer  "team_id",                          :null => false
    t.integer  "tournament_id",                    :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "challonge_id",  :default => 0
    t.boolean  "is_inactive",   :default => false, :null => false
  end

  add_index "tournament_teams", ["team_id", "tournament_id"], :name => "index_tournament_teams_on_team_id_and_tournament_id", :unique => true
  add_index "tournament_teams", ["team_id"], :name => "index_tournament_teams_on_team_id"
  add_index "tournament_teams", ["tournament_id"], :name => "index_tournament_teams_on_tournament_id"

  create_table "tournaments", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "description"
    t.text     "rules"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "current_week_num"
    t.boolean  "active",           :default => true,   :null => false
    t.string   "tournament_type",  :default => "",     :null => false
    t.string   "bracket_type",     :default => ""
    t.string   "elimination_type", :default => ""
    t.integer  "bracket_size",     :default => 0
    t.string   "challonge_url",    :default => ""
    t.string   "challonge_img",    :default => ""
    t.string   "challonge_state",  :default => ""
    t.integer  "challonge_id",     :default => 0
    t.boolean  "playoffs",         :default => false
    t.string   "category",         :default => "none", :null => false
    t.boolean  "can_join",         :default => true,   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
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
    t.integer  "roles_mask"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "gravatar_email",         :default => "", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
