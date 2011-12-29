require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :all
  render_views

  it "create action should render new template when model is invalid" do
    flexmock(User).new_instances.should_receive(:save).once.and_return(false)
    post :create
  end

  it "create action should redirect when model is valid" do
    flexmock(@controller, :current_user => User.new)
    flexmock(User).new_instances.should_receive(:save).once.and_return(true)
    post :create
    response.should redirect_to(root_url)
    session['user_id'].should == assigns['user'].id
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    flexmock(@controller, :current_user => User.new)
    get :edit, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => "ignored"
    response.should redirect_to(login_url)
  end
end
