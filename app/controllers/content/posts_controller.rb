class Content::PostsController < ApplicationController
  before_filter :textile_help, :login_required, :except => [:archive, :index, :show]

  expose(:post) do
    if params[:id]
      Content::Post.find(params[:id])
    else
      Content::Post.new
    end
  end

  expose(:posts) { Content::Post.where(state: 'published').all(order: "created_at DESC", limit: 10) }

  def archive
    @posts = Content::Post.all(:select => "title, id, created_at", :order => "created_at DESC")
    @post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
  end

  def create
    @post = Content::Post.new(params[:content_post])
    @post.user = current_user
    if @post.save!
      if params[:preview_button]
        redirect_to @post, :notice => "Previewing the post"
      else
        @post.publish
        redirect_to @post, :notice => "Successfully created post."
      end
    else
      render :action => 'new'
    end
  end

  def update
    @post = Content::Post.find(params[:id])
    if @post.update_attributes(params[:content_post])
      if params[:preview_button]
        redirect_to @post, :notice => "Previewing the post"
      else
        @post.publish
        redirect_to @post, :notice  => "Successfully updated post."
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post = Content::Post.find(params[:id])
    @post.destroy
    redirect_to content_posts_url, :notice => "Successfully destroyed post."
  end

  def unpublished
    @post = Content::Post.where(state: 'pending').all(order: "created_at DESC", limit: 10) 
  end

  private
  def textile_help
    @textile_ref = textile_ref
  end
end
