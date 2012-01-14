FactoryGirl.define do
  factory :post do
    title "Post #{UUID.generate}"
    body Lorem::Base.new('paragraphs', 1).output
  end
end

