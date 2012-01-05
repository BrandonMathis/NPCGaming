desc "Create a post with lorem text"
task :new_post => :environment do
  body = Lorem::Base.new('paragraphs', 3).output
  puts body
  user = User.find_by_username "admin"
  user.posts.create( :title => "Test Post #{Time.now.to_s}", :body => body)
end
