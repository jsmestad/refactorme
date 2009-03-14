require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = Factory.attributes_for(:user)
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  
  it "should respond to admin?" do
    @user = Factory.create(:admin)
    @user.is_admin?.should == true
  end
  
end
