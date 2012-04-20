require 'spec_helper'

describe CategoriesController do
  before do
    @category = FactoryGirl.create(:post_with_category)
  end

  it "category should render index template" do
    get :show, :id => @category.id
    response.should render_template 'posts/index'
  end
end
