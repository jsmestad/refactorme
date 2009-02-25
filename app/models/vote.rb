class Vote < ActiveRecord::Base
  belongs_to :refactor
  belongs_to :user
  
  named_scope :positive, :conditions => ["score > 0"]
  named_scope :negative, :conditions => ["score < 0"]
end
