FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Internet.unique.username }
    role { "general" }
    line_user_id { SecureRandom.hex(10) }
    avatar { File.open(Rails.root.join('app', 'assets', 'images', 'placeholder.png')) }
  end
end

