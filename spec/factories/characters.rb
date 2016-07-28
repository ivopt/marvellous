FactoryGirl.define do
  factory :character, class: Character do
    sequence(:id) { |n| n }
    name { "Character #{id}" }
  end
end
