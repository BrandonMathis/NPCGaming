class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name

  has_many :categorized_posts, dependent: :destroy
  has_many :posts, through: :categorized_posts, order: 'created_at DESC', class_name: 'Content::Post'

  validates_presence_of :name
  validates_uniqueness_of :name
end
