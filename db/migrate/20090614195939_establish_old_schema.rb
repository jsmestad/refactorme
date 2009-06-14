class EstablishOldSchema < ActiveRecord::Migration
  def self.up
    create_table "delayed_jobs" do |t|
      t.integer  "priority",   :default => 0
      t.integer  "attempts",   :default => 0
      t.text     "handler"
      t.string   "last_error"
      t.datetime "run_at"
      t.datetime "locked_at"
      t.datetime "failed_at"
      t.string   "locked_by"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "refactors" do |t|
      t.text     "code"
      t.integer  "user_id"
      t.integer  "snippet_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "gist_id"
      t.text     "context"
      t.integer  "vote_score_cache", :default => 0
    end

    add_index "refactors", ["snippet_id"], :name => "index_refactors_on_snippet_id"
    add_index "refactors", ["user_id"], :name => "index_refactors_on_user_id"

    create_table "snippets" do |t|
      t.string   "title"
      t.text     "code"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.date     "displayed_on"
      t.integer  "position"
      t.integer  "gist_id"
      t.text     "context"
    end

    add_index "snippets", ["displayed_on"], :name => "index_snippets_on_displayed_on"
    add_index "snippets", ["position"], :name => "index_snippets_on_position"

    create_table "users" do |t|
      t.string   "login"
      t.string   "email"
      t.string   "crypted_password"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "persistence_token"
      t.integer  "login_count"
      t.datetime "last_login_at"
      t.datetime "current_login_at"
      t.string   "perishable_token"
      t.string   "password_salt"
      t.boolean  "admin"
      t.string   "github_username"
      t.string   "github_api_key"
      t.boolean  "active",            :default => false
    end

    add_index "users", ["active"], :name => "index_users_on_active"
    add_index "users", ["login"], :name => "index_users_on_login"
    add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
    add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

    create_table "votes" do |t|
      t.integer  "user_id"
      t.integer  "refactor_id"
      t.integer  "score"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "votes", ["refactor_id"], :name => "index_votes_on_refactor_id"
    add_index "votes", ["score"], :name => "index_votes_on_score"
    add_index "votes", ["user_id"], :name => "index_votes_on_user_id"
  end

  def self.down
    drop_table :delayed_jobs
    drop_table :users
    drop_table :snippets
    drop_table :refactors
    drop_table :votes
  end
end
