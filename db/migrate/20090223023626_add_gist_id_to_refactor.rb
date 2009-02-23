class AddGistIdToRefactor < ActiveRecord::Migration
  def self.up
    add_column :refactors, :gist_id, :integer
  end

  def self.down
    remove_column :refactors, :gist_id
  end
end
