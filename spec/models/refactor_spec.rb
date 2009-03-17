require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Refactor do
  
  before(:each) do
    @valid_attributes = Factory.attributes_for(:refactor)
    Factory.build(:refactor)
  end
  
  it { should belong_to(:user) }
  it { should belong_to(:snippet) }
  it { should validate_presence_of(:code) }
  
  
end