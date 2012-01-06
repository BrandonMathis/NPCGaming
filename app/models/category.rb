class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :posts

  validates_presence_of :name
  validates_uniqueness_of :name
end
