class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    category = Category.find(params[:id])
    @posts = category.posts
    render 'posts/index'
  end
end
