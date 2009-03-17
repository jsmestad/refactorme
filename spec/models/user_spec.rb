require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  
  before(:each) do
    @valid_attributes = Factory.attributes_for(:user)
    Factory(:user)
  end

  it { should ensure_length_of(:login).is_at_least(2).is_at_most(15) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:refactors) }
  it { should have_many(:snippets) }
  it { should have_many(:votes) }
  it { should have_named_scope(:top_refactors) }

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  
  it "should respond to admin?" do
    @user = Factory.create(:admin)
    @user.is_admin?.should == true
  end
  
end
