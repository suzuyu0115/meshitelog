class PublishPostJob < ApplicationJob
  queue_as :default

  def perform(post)
    post.update(published: true)
    line_client = LineClient.new
    post.deliveries.each do |delivery|
      line_client.push_message(delivery.user.uid, "新しい投稿があります: #{post.title}")
    end
  end
end
