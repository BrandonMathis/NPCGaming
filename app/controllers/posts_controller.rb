class PostsController < ApplicationController
  before_filter :textile_help, :login_required, :except => [:archive, :index, :show, :category]

  def index
    @posts = Post.all :order => "created_at DESC", :limit => 10
  end

  def show
    @post = Post.find(params[:id])
  end

  def category
    @posts = Post.find_by_category(params[:category_name]).order("created_at DESC")
    render 'index'
  end

  def archive
    @posts = Post.all(:select => "title, id, created_at", :order => "created_at DESC")
    @post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.save
      redirect_to @post, :notice => "Successfully created post."
    else
      render :action => 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice  => "Successfully updated post."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, :notice => "Successfully destroyed post."
  end

  private

  def textile_help
    @textile_ref = textile_ref
  end
end
