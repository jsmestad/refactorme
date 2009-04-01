class AddVoteScoreCacheToRefactor < ActiveRecord::Migration
  def self.up
    add_column :refactors, :vote_score_cache, :integer, :default => 0
  end

  def self.down
    remove_column :refactors, :vote_score_cache
  end
end
