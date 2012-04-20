require 'spec_helper'

describe Content::Post do
  it 'should be valid' do
    Content::Post.new(title: 'ram', body: 'rod').should be_valid
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
      @post = Content::Post.create(title: 'test', body: 'h1. This Is A Test')
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
      posts = Content::Post.find_by_category(category)
      posts.length.should == 5
    end
  end

  describe 'state' do
    before do
      @post = FactoryGirl.create(:post)
    end

    it 'has initial state of pending' do
      @post.state.should == 'pending'
    end

    it 'can be published' do
      @post.publish
      @post.reload.state.should == 'published'
    end
  end
end
