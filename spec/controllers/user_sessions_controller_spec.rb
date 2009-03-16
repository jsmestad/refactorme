require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  before do
    @user = Factory.create(:user)
  end

  it "should get new" do
    get :new
    response.should be_success
  end

  it "should create user session" do
    post :create, :user_session => { :login => @user.login, :password => "benrocks" }
    user_session = UserSession.find
    @user.should == user_session.user
    response.should redirect_to(root_path)
  end

  it "should destroy user session" do
    set_session_for(@user)
    delete :destroy
    UserSession.find.should be_nil
    response.should redirect_to(new_user_session_path)
  end

end
