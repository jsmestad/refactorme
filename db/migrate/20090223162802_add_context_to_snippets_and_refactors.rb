class AddContextToSnippetsAndRefactors < ActiveRecord::Migration
  def self.up
    add_column :snippets, :context, :text
    add_column :refactors, :context, :text
  end

  def self.down
    remove_column :refactors, :context
    remove_column :snippets, :context
  end
end
