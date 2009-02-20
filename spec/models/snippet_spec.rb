require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Snippet do
  before(:each) do
    @valid_attributes = Factory.attributes_for(:snippet)
  end

  it "should create a new instance given valid attributes" do
    Snippet.create!(@valid_attributes)
  end
end
