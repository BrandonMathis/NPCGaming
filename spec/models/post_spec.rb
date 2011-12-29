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

  describe "tags" do
    before do
      @post = Post.create :tags => %w{a b c}
    end

    it "should store tags as a list" do
      @post.tags.should be_a_kind_of Array
    end

    it "should have the list of tags" do
      @post.tags.should == %w{a b c}
    end
  end
end
