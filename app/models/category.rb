class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :categorized_movies, :dependent => :destroy
  has_many :posts, :through => :categorized_posts

  validates_presence_of :name
  validates_uniqueness_of :name
end
