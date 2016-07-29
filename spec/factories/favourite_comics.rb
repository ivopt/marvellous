FactoryGirl.define do
  factory :favourite_comic do
    sequence(:comic_id) { |n| n }
  end
end
