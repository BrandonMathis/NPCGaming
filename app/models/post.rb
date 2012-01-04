class Post < ActiveRecord::Base
  attr_accessible :title, :body, :parsed_body, :tags

  belongs_to :user
  has_and_belongs_to_many :tags

  before_save :parse_textile_body

  alias :author :user

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
