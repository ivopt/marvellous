FactoryGirl.define do
  factory :comic, class: Comic do
    sequence(:id) { |n| n }
    title { "Comic #{id}" }
    thumbnail_path { "http://example.com/comic#{id}.jpg" }
    date { id.days.ago }
  end
end
