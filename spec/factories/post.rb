FactoryGirl.define do
  factory :post, class: 'Content::Post' do
    title "This is the title"
    body 'This is the body'

    factory :post_with_category do
      categories { [FactoryGirl.build(:category)] }
    end
  end
end
