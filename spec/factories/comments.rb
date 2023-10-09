FactoryBot.define do
  factory :comment do
    body { "コメントです。" }
    user
    post
  end
end
