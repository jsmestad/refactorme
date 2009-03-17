require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vote do
  
  # before(:each) do
  #   @valid_attributes = Factory.attributes_for(:vote)
  #   Factory.build(:vote)
  # end
  
  it { should belong_to(:user) }
  it { should belong_to(:refactor) }
  it { should validate_presence_of(:score) }
  
end