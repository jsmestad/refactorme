class Vote < ActiveRecord::Base
  belongs_to :refactor
  belongs_to :user
end
