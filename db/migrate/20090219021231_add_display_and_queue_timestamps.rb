class AddDisplayAndQueueTimestamps < ActiveRecord::Migration
  def self.up
    add_column :snippets, :displayed_on, :date, :unique => true
    add_column :snippets, :queue_position, :integer, :unique => true

    add_index :snippets, :displayed_on
  end

  def self.down
    remove_column :snippets, :queue_position
    remove_column :snippets, :displayed_on
  end
end
