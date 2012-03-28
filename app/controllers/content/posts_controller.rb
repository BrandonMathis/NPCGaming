class Content::PostsController < ApplicationController
  before_filter :textile_help, :login_required, :except => [:archive, :index, :show]

  def index
    @posts = Content::Post.all :order => "created_at DESC", :limit => 10
  end

  def show
    @post = Content::Post.find(params[:id])
  end

  def archive
    @posts = Content::Post.all(:select => "title, id, created_at", :order => "created_at DESC")
    @post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
  end

  def new
    @post = Content::Post.new
  end

  def create
    @post = Content::Post.new(params[:content_post])
    @post.user = current_user
    if @post.save
      redirect_to @post, :notice => "Successfully created post."
    else
      render :action => 'new'
    end
  end

  def edit
    @post = Content::Post.find(params[:id])
  end

  def update
    @post = Content::Post.find(params[:id])
    if @post.update_attributes(params[:content_post])
      redirect_to @post, :notice  => "Successfully updated post."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post = Content::Post.find(params[:id])
    @post.destroy
    redirect_to content_posts_url, :notice => "Successfully destroyed post."
  end

  private

  def textile_help
    @textile_ref = textile_ref
  end
end
