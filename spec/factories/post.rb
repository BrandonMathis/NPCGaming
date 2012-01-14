FactoryGirl.define do
  factory :post do
    title "Post #{Time.now.to_i}"
    body Lorem::Base.new('paragraphs', 1).output
  end
end

