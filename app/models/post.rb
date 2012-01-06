class Post < ActiveRecord::Base
  attr_accessible :title, :body, :parsed_body, :category_name

  belongs_to :user
  belongs_to :category

  before_save :parse_textile_body

  alias :author :user

  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by_name(name) if name.present?
  end

  def html_body
    parsed_body.html_safe if parsed_body
  end

  def list_tags
    self.tags.map { |tag| tag.name }
  end

  private
  def parse_textile_body
    self.parsed_body = RedCloth.new(self.body).to_html if self.body
  end
end
