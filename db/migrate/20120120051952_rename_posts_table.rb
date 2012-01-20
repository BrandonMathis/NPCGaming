class RenamePostsTable < ActiveRecord::Migration
  def change
    rename_table :posts, :content_posts
  end
end
