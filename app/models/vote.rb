class Vote < ActiveRecord::Base
  belongs_to :refactor
  belongs_to :user
  
  validates_presence_of :score
  
  after_save :update_score_cache
  
  named_scope :positive, :conditions => ["score > 0"]
  named_scope :negative, :conditions => ["score < 0"]
  
  private
    def update_score_cache
      self.refactor.update_attribute( :vote_score_cache, self.refactor.vote_score_cache + self.score )
    end
end
