class TagToCategory < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :name
      t.timestamps
      # add_index :categories, :slug, unique: true
    end

    add_column :posts, :category_id, :integer
    drop_table :tags
    drop_table :posts_tags
  end

  def down
    drop_table :categories
  end
end
