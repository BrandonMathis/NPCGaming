require File.dirname(__FILE__) + '/../spec_helper'

describe Post do
  it 'should be valid' do
    Post.new.should be_valid
  end

  it 'should have proper attributes' do
    @user = User.create(username: 'User', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    p = @user.posts.create(categories_string: 'Red, Blue')
    p.author.should be_a_kind_of User
    p.categories.length.should == 2
    p.categories_string.should =~ /Red/
  end

  describe 'RedCloth' do
    before do
      @post = Post.create :body => 'h1. This Is A Test'
    end

    it 'should have a parsed body' do
      @post.parsed_body.should == '<h1>This Is A Test</h1>'
    end

    it 'should have a redcloth body' do
      @post.body.should == 'h1. This Is A Test'
    end
  end

  describe 'find posts with categories' do
    let(:category) {"generated"}

    before :all do
      5.times{ FactoryGirl.create(:post, :categories_string => category) }
      2.times{ FactoryGirl.create(:post) }
    end

    it 'returns the lists of posts with a common category' do
      posts = Post.find_by_category(category)
      posts.length.should == 5
    end
  end
end
