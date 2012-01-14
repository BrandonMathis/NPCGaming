class CreateCategorizedPosts < ActiveRecord::Migration
  def change
    create_table :categorized_posts do |t|
      t.column :post_id, :integer, :null => false
      t.column :category_id, :integer, :null => false
    end
  end
end
