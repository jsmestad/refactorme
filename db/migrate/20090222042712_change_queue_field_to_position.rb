class ChangeQueueFieldToPosition < ActiveRecord::Migration
  def self.up
    rename_column :snippets, :queue_position, :position
  end

  def self.down
    rename_column :snippets, :position, :queue_position
  end
end
