require File.dirname(__FILE__) + '/../spec_helper'

describe CategoriesController do
  category = FactoryGirl.create(:post_with_category)

  it "category should render index template" do
    get :show, :id => category.id
    response.should render_template 'posts/index'
  end
end
