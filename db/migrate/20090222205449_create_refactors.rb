class CreateRefactors < ActiveRecord::Migration
  def self.up
    create_table :refactors do |t|
      t.text :code
      t.belongs_to :user
      t.belongs_to :snippet
      t.timestamps
    end
  end

  def self.down
    drop_table :refactors
  end
end
