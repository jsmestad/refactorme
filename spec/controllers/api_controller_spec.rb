require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApiController do

  describe "GitHub Post-Receive Hook" do
    before do
      @sample_commit = ''
      File.open("#{RAILS_ROOT}/spec/fixtures/github_commit.json", "r").each_line { |line| @sample_commit += line }
      @fetch_commit = ''
      File.open("#{RAILS_ROOT}/spec/fixtures/github_grab_commit.json", "r").each_line { |line| @fetch_commit += line }
      #RestClient.stub!(:get).and_return(@fetch_commit)
      Factory(:user, :github_username => 'jsmestad')
      Factory(:user, :email => 'chris@ozmm.org')
    end
    
    it "should map { :controller => 'api', :action => 'github_commit' } to /api/github/track_commit" do
      route_for(:controller => "api", :action => "github_commit").should == {:path => "/api/github/track_commit", :method => :post}
    end
   
    it "should match commit user by login or email" do
      post :github_commit, {:payload => @sample_commit}
      Delayed::Job.count.should == 1 
    end
    
    it "should generate a snippet for a matched commit" do
      lambda do
        post :github_commit, {:payload => @sample_commit}
        Delayed::Job.work_off
      end.should change(Snippet, :count).by(1)
    end

    after(:each) do
      Delayed::Job.work_off
    end
  end

end
