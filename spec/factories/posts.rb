FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraph(sentence_count: 5) }
    food_image { File.open(Rails.root.join('spec/fixtures/food_image.jpg')) }
    published { [true, false].sample }
    published_at { Time.now }
    association :user
    association :author, factory: :user
  end
end
