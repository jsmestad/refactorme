require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Refactor do
  
  before(:each) do
    @valid_attributes = Factory.attributes_for(:refactor)
    @refactor = Factory.build(:refactor)
  end
  
  it { should belong_to(:user) }
  it { should belong_to(:snippet) }
  it { should validate_presence_of(:code) }
  
  it "should have 0 for score cache" do
    @refactor.vote_score_cache.should == 0
  end
  
  describe "score cache" do
    before(:each) do
      @refactor.save
      @refactor.votes.create(:score => 1)
    end
    
    it "should have 1 for score cache" do
      @refactor.reload
      @refactor.vote_score_cache.should == 1
    end
    
  end
  
  
end

