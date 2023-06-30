20.times do |index|                    # postsのダミーデータ
  Post.create!(
    title: "食べ物#{index}",
    content: "これは#{index}点の美味しさ"
  )
end
