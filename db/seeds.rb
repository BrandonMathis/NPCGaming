# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create( username: "admin", password: 'password', password_confirmation: 'password', email: 'admin@example.com')

if Rails.env == 'development' && Content::Post.find( :all ).empty?
  user = User.find_by_username "admin"
  body = Lorem::Base.new('paragraphs', 3).output
  Category.create(name: "AAAAAA")
  Category.create(name: "BBBBBB")
  2.times { user.posts.create( title: "Test Post #{Random.rand(10)}", body: body, categories_string: "AAAAAA") }
end
