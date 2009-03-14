class AddAdminFlagToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean
    
    add_index :users, :login
    add_index :users, :persistence_token
    add_index :users, :last_request_at
  end

  def self.down
    User.find_by_login('jstad').destroy
    remove_index :users, :login
    remove_index :users, :persistence_token
    remove_index :users, :last_request_at
    
    remove_column :users, :admin
  end
end
