require 'spec_helper'

describe Content::PostsController do
  describe 'User Not Logged In' do
    before do
      @post = Content::Post.create(body: 'This is the body', title: 'this is the title')
    end

    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end

    it "show action should render show template" do
      get :show, :id => Content::Post.first
      response.should render_template(:show)
    end
  end

  describe "User Logged In" do
    before do
      @post = Content::Post.create(body: 'This is the body', title: 'this is the title')
      flexmock(@controller, :login_required => true)
    end

    it "new action should render new template" do
      get :new
      response.should render_template(:new)
    end

    it 'will preview the post' do
      get :preview, id: Content::Post.first
      response.should render_template(:show)
    end

    it "create action should render new template when model is invalid" do
      flexmock(@controller, :login_required => true)
      Content::Post.any_instance.stubs(:valid?).returns(false)
      post :create
      response.should render_template(:new)
    end

    it "create action should redirect when model is valid" do
      Content::Post.any_instance.stubs(:valid?).returns(true)
      post :create
      response.should redirect_to(content_post_url(assigns[:post]))
    end

    it "edit action should render edit template" do
      get :edit, :id => Content::Post.first
      response.should be_successful
      response.should render_template(:edit)
    end
  end
end
