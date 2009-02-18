class AddUsersPasswordResetFields < ActiveRecord::Migration
  def self.up
    add_column :users, :perishable_token, :string, :null => false

    add_index :users, :perishable_token
    add_index :users, :email

    add_column :users, :password_salt, :string
  end

  def self.down
    remove_index :users, :perishable_token
    remove_index :users, :email
    
    remove_column :users, :perishable_token
  
    remove_column :users, :password_salt
  end
end