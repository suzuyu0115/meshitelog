class PublishPostJob < ApplicationJob
  queue_as :default

  def perform(post)
    post.update(published: true)
    post.notify_line
  end
end
