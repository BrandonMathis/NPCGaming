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

  describe 'post state' do
    let(:content_post_params) { { body: 'they body', title: 'the title' } }

    before do
      flexmock(@controller, :login_required => true)
    end

    it "create action sets post to published when not previewed" do
      post :create, content_post: content_post_params
      Content::Post.first.state.should == 'published'
    end

    it 'sets posts status to pending if preview button is used' do
      post :create, preview_button: true, content_post: content_post_params
      Content::Post.first.state.should == 'pending'
    end
  end
end
