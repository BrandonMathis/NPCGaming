class Post < ActiveRecord::Base
  attr_accessible :title, :body, :parsed_body

  belongs_to :user

  before_save :redcloth_body

  alias :author :user

  def html_body
    parsed_body.html_safe if parsed_body
  end

  private
  def redcloth_body
    self.parsed_body = RedCloth.new(self.body).to_html if self.body
  end
end
