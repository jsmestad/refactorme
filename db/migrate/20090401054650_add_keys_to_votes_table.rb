class AddKeysToVotesTable < ActiveRecord::Migration
  def self.up
    add_index :votes, :score
    add_index :votes, :refactor_id
    add_index :votes, :user_id
    add_index :snippets, :position
    add_index :users, :active
    add_index :refactors, :user_id
    add_index :refactors, :snippet_id
  end

  def self.down
    remove_index :votes, :score
    remove_index :votes, :refactor_id
    remove_index :votes, :user_id
    remove_index :snippets, :position
    remove_index :users, :active
    remove_index :refactors, :user_id
    remove_index :refactors, :snippet_id
  end
end
