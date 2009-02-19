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
    post :create, :user_session => { :login => "johndoe", :password => "benrocks" }
    user_session = UserSession.find
    @user.should == user_session.user
    response.should redirect_to(account_path)
  end

  it "should destroy user session" do
    delete :destroy
    UserSession.find.should be_nil
    response.should redirect_to(login_path)
  end

end