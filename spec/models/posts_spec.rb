require File.dirname(__FILE__) + '/../spec_helper'

describe Post do
  it "should be valid" do
    Post.new.should be_valid
  end

  it "should have proper attributes" do
    @user = User.create(username: "User", email: "user@example.com", password: "password", password_confirmation: "password")
    p = @user.posts.create(category_name: "Shake and Bake")
    p.author.should be_a_kind_of User
    p.category_name.should == "Shake and Bake"
  end

  describe "RedCloth" do
    before do
      @post = Post.create :body => "h1. This Is A Test"
    end

    it "should have a parsed body" do
      @post.parsed_body.should == "<h1>This Is A Test</h1>"
    end

    it "should have a redcloth body" do
      @post.body.should == "h1. This Is A Test"
    end
  end
end
