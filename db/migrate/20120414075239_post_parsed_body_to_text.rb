class PostParsedBodyToText < ActiveRecord::Migration
  def up
    change_column :posts, :parsed_body, :text
  end

  def down
    change_column :posts, :parsed_body, :string
  end
end
