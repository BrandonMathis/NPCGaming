FactoryGirl.define do
  factory :post, class: 'Content::Post' do
    title "Post #{UUID.generate}"
    body Lorem::Base.new('paragraphs', 1).output

    factory :post_with_category do
      categories { [FactoryGirl.build(:category)] }
    end
  end
end
