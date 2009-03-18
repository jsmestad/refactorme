require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def create_snippet
  #@snippet = mock(Snippet)
  Factory.create(:snippet)
end

def setup_admin
  admin = Factory.create(:admin)
  set_session_for(admin)
end

describe SnippetsController do
  integrate_views
  
  before do
    
  end

  describe "GET /snippets" do
    before(:each) do
      create_snippet
    end
    
    it "should fail without admin" do
      get :index
      response.should_not be_success
    end
    
    it "should be ok when admin" do
      setup_admin
      get :index
      response.should be_success
    end
  end

  describe "GET /snippets/1" do
    before(:each) do
      @p = create_snippet
    end
    
    it "should fail without admin" do
      get :show, :id => @p.to_param
      response.should_not be_success
    end
    
    it "should be ok when admin" do
      setup_admin
      get :show, :id => @p.to_param
      response.should be_success
    end
  end

  describe "GET /snippets/new" do
    before(:each) do
      @reg_user = Factory.create(:user)
    end
    
    it "should fail without login" do
      get :new
      response.should_not be_success
      response.should redirect_to(login_url)
    end
    
    it "should be ok when logged in" do
      set_session_for(@reg_user)
      get :new
      response.should be_success
    end
  end

  describe "snippet /snippets" do
    def do_snippet
      set_session_for(Factory.create(:admin))
      post :create, :snippet => Factory.attributes_for(:snippet)
    end

    it "should create a new snippet" do
      lambda { do_snippet }.should change(Snippet, :count).by(1)
    end

    it "should redirect to the snippets index" do
      do_snippet
      response.should redirect_to(root_url)
    end
  end

  describe "PUT /snippets/1" do
    before(:each) do
      @snippet = create_snippet
      set_session_for(Factory.create(:admin))
    end

    def do_put
      put :update, :id => @snippet.to_param, :snippet => {:title => 'Change me'}
    end

    it "should update the snippet" do
      do_put
      @snippet.reload.title.should == 'Change me'
    end

    it "should render the snippet" do
      do_put
      response.should redirect_to(snippet_path(@snippet))
    end
  end

  describe "DELETE /snippets/1" do
    before(:each) do
      @snippet = create_snippet
    end

    def do_delete
      set_session_for(Factory.create(:admin))
      delete :destroy, :id => @snippet.id
    end

    it "should require an admin" do
      pending
      delete :destroy, :id => @snippet.id
      response.should_not be_success
    end

    it "should destroy the snippet" do
      pending
      do_delete
      lambda {@snippet.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end

    it "should redirect to the index" do
      pending
      do_delete
      response.should redirect_to(snippets_url)
    end
  end
end