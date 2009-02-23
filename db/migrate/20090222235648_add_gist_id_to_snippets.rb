class AddGistIdToSnippets < ActiveRecord::Migration
  def self.up
    add_column :snippets, :gist_id, :integer
  end

  def self.down
    remove_column :snippets, :gist_id
  end
end
