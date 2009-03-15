require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AccountsController do
  integrate_views
  
  describe "given a user exists" do
    before do
      @user = Factory.create(:user)
    end
  
    it "should get edit" do
      set_session_for(@user)
      get :edit, :id => @user.id
      response.should be_success
    end

    it "should update user" do
      set_session_for(@user)
      put :update, :id => @user.id, :user => { }
      response.should redirect_to(account_path)
    end
  end
  
end
