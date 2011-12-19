class AddParsedBodyToPost < ActiveRecord::Migration
  def change
    add_column :posts, :parsed_body, :string
  end
end
