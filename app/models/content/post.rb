class Content::Post < ActiveRecord::Base
  include Content
  attr_accessible :title, :body, :parsed_body, :categories_string

  belongs_to :user
  has_many :categorized_posts, :dependent => :destroy
  has_many :categories, :through => :categorized_posts

  validates_presence_of :title
  validates_presence_of :body

  before_save :parse_textile_body

  scope :find_by_category, lambda{ |category| joins(:categories).where('categories.name = ?', category) }

  alias :author :user

  def categories_string
    categories.map(&:name).join(", ")
  end

  def categories_string=(cats)
    return true if cats.blank?
    self.categories = cats.split(", ").map do |cat|
      Category.find_or_create_by_name(cat)
    end
  end

  def published?
    state == 'published'
  end

  state_machine initial: :pending do
    state :pending

    state :published

    event :publish do
      transition pending: :published
    end
  end
end
