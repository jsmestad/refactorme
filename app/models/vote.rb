class Vote < ActiveRecord::Base
  belongs_to :refactor
  belongs_to :user
  
  validates_presence_of :score
  
  named_scope :positive, :conditions => ["score > 0"]
  named_scope :negative, :conditions => ["score < 0"]
end
