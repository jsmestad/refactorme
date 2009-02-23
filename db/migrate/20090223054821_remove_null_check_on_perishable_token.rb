class RemoveNullCheckOnPerishableToken < ActiveRecord::Migration
  def self.up
    change_column :users, :perishable_token, :string, :null => true
  end

  def self.down
    change_column :users, :perishable_token, :string, :null => false
  end
end
