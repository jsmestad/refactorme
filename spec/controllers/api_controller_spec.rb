require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApiController do

  describe "GitHub Post-Receive Hook" do
    it "should map { :controller => 'api', :action => 'github_commit' } to /api/github/track_commit" do
      route_for(:controller => "api", :action => "github_commit").should == {:path => "/api/github/track_commit", :method => :post}
    end
  end
  

end
