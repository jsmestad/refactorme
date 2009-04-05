class RemoveExtraIndexesOnUser < ActiveRecord::Migration
  def self.up
    remove_index :users, :email
    remove_index :users, :last_request_at
    remove_column :users, :last_login_ip
    remove_column :users, :current_login_ip
    remove_column :users, :last_request_at
  end

  def self.down
    add_column :users, :last_request_at, :datetime
    add_column :users, :last_login_ip, :string
    add_column :users, :current_login_ip, :string
    add_index :users, :email
    add_index :users, :last_request_at
  end
end
