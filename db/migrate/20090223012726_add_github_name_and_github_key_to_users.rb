class AddGithubNameAndGithubKeyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :github_username, :string
    add_column :users, :github_api_key, :string
  end

  def self.down
    remove_column :users, :github_username
    remove_column :users, :github_api_key
  end
end
