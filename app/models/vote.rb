class Vote < ActiveRecord::Base
  include DataMapper::Resource

  property :id, Serial
  property :score, Integer, :nullable => false

  belongs_to :snippet
  belongs_to :user
end
