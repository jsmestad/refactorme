require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApiController do

  describe "GitHub Post-Receive Hook" do
    before do
      @sample_commit = <<-EOF
      { 
        "before": "5aef35982fb2d34e9d9d4502f6ede1072793222d",
        "repository": {
          "url": "http://github.com/defunkt/github",
          "name": "github",
          "description": "You're lookin' at it.",
          "watchers": 5,
          "forks": 2,
          "private": 1,
          "owner": {
            "email": "chris@ozmm.org",
            "name": "defunkt" 
          }
        },
        "commits": [
          {
            "id": "41a212ee83ca127e3c8cf465891ab7216a705f59",
            "url": "http://github.com/defunkt/github/commit/41a212ee83ca127e3c8cf465891ab7216a705f59",
            "author": {
              "email": "chris@ozmm.org",
              "name": "defunkt" 
          },
          "message": "okay i give in",
          "timestamp": "2008-02-15T14:57:17-08:00",
          "added": ["filepath.rb"]
          },
          {
            "id": "de8251ff97ee194a289832576287d6f8ad74e3d0",
            "url": "http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0",
            "author": {
              "email": "chris@ozmm.org",
              "name": "defunkt" 
            },
            "message": "update pricing a tad",
            "timestamp": "2008-02-15T14:36:34-08:00" 
          }
        ],
        "after": "de8251ff97ee194a289832576287d6f8ad74e3d0",
        "ref": "refs/heads/master" 
      }
      EOF
      Factory(:user, :github_username => 'defunkt')
      Factory(:user, :email => 'chris@ozmm.org')
    end
    
    it "should map { :controller => 'api', :action => 'github_commit' } to /api/github/track_commit" do
      route_for(:controller => "api", :action => "github_commit").should == {:path => "/api/github/track_commit", :method => :post}
    end
    
    it "should match commit user on username" do
      response = post :github_commit, {:payload => @sample_commit.to_s}
      response.body.should eql("Submission accepted for user: defunkt")
    end
    
    it "should match commit user on email"
    it "should flag the commit"
    it "should generate a snippet for a matched commit"
  end

end
