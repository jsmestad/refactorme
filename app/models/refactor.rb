class Refactor < ActiveRecord::Base
  belongs_to :snippet
  belongs_to :user
end