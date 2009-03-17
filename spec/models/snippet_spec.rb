require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Snippet do
  before(:each) do
    @valid_attributes = Factory.attributes_for(:snippet)
    Factory(:snippet)
  end
  
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:context) }
  it { should ensure_length_of(:context).is_at_least(10) }

  it "should create a new instance given valid attributes" do
    Snippet.create!(@valid_attributes)
  end
end
