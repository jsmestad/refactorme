require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  integrate_views
  
  it "should get new" do
    get :new
    response.should be_success
  end

  it "should create user" do
    lambda {
      post :create, :user => { :login => "ben", :password => "benrocks", :password_confirmation => "benrocks", :email => "myemail@email.com" }
    }.should change(User, :count)
    
    response.should redirect_to(root_path)
  end
  
  describe "given a user exists" do
    before do
      @user = Factory.create(:user)
    end
  
    it "should show user" do
      set_session_for(@user)
      get :show
      response.should be_success
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
