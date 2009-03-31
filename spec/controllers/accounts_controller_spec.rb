require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AccountsController do
  integrate_views
  
  describe "given a user exists" do
    before do
      @user = Factory.create(:user)
    end
  
    it "should get edit" do
      set_session_for(@user)
      get :edit
      response.should be_success
    end

    it "should update user" do
      set_session_for(@user)
      put :update, :user => { :email => 'dude@pants.com' }
      response.should redirect_to(user_path(@user))
    end
  end
  
end
