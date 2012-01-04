require File.dirname(__FILE__) + '/../spec_helper'

describe Post do
  it "should be valid" do
    Post.new.should be_valid
  end

  it "should have proper attributes" do
    @user = User.create(username: "User", email:"user@example.com", password:"password", password_confirmation: "password")
    tags = [Tag.create(:name => "shake"), Tag.create(:name => "bake")]
    p = @user.posts.create(:tags => tags)
    p.author.should be_a_kind_of User
    p.tags.first.should be_a_kind_of Tag
    p.list_tags.should == %w{shake bake}
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
