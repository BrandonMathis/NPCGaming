class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    category = Category.find(params[:id])
    @posts = category.posts
    render 'content/posts/index'
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(post_params)
    if @category.save
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  private
  def post_params
    params[:category].slice(:name)
  end
end
