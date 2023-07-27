10.times do                            # userのダミーデータ
  User.create!(
    name: Faker::Games::Pokemon.name,
    line_user_id: Faker::Games::Pokemon.location,
  )
end

20.times do |index|                    # postsのダミーデータ
  Post.create!(
    user: User.offset(rand(User.count)).first,
    title: "食べ物#{index}",
    content: "これは#{index}点の美味しさ"
  )
end
