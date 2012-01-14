class Post < ActiveRecord::Base
  attr_accessible :title, :body, :parsed_body, :categories_string

  belongs_to :user
  has_many :categorized_posts, :dependent => :destroy
  has_many :categories, :through => :categorized_posts

  before_save :parse_textile_body

  scope :find_by_category, lambda{ |category| joins(:categories).where('categories.name = ?', category) }

  alias :author :user

  def html_body
    parsed_body.html_safe if parsed_body
  end

  def categories_string
    categories.map(&:name).join(", ")
  end

  def categories_string=(cats)
    return true if cats.blank?
    self.categories = cats.split(", ").map do |cat|
      Category.find_or_create_by_name(cat)
    end
  end

  private
  def parse_textile_body
    self.parsed_body = RedCloth.new(self.body).to_html if self.body
  end
end
