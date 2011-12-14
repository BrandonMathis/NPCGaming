require File.dirname(__FILE__) + '/../spec_helper'

describe Post do
  it "should be valid" do
    Post.new.should be_valid
  end

  it "should have author" do
    @user = User.create(username: "User", email:"user@example.com", password:"password", password_confirmation: "password")
    p = @user.posts.create
    p.author.should be_a_kind_of User
  end
end
