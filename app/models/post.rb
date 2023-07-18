# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  food_image   :string
#  published    :boolean          default(FALSE), not null
#  published_at :datetime
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_posts_on_author_id  (author_id)
#  index_posts_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  mount_uploader :food_image, FoodImageUploader
  belongs_to :user
  belongs_to :author, class_name: "User"
  has_many :deliveries, dependent: :destroy
  has_many :recipients, through: :deliveries, source: :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65_535 }

  after_create_commit :notify_line
  after_create_commit :schedule_publication

  def self.ransackable_associations(_auth_object = nil)
    ["bookmarks", "comments", "user"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["content", "created_at", "title"]
  end

  def notify_line
      # 予約投稿か否かを判定
      return unless published?

      line_client = LineClient.new
      flex_contents = {
        type: "bubble",
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "text",
              text: "新しい投稿があります",
              weight: "bold",
              size: "xl"
            },
            {
              type: "box",
              layout: "vertical",
              margin: "lg",
              spacing: "sm",
              contents: [
                {
                  type: "box",
                  layout: "baseline",
                  spacing: "sm",
                  contents: [
                    {
                      type: "text",
                      text: "タイトル",
                      color: "#aaaaaa",
                      size: "sm",
                      flex: 1
                    },
                    {
                      type: "text",
                      text: title,
                      wrap: true,
                      color: "#666666",
                      size: "sm",
                      flex: 5
                    }
                  ]
                },
                {
                  type: "box",
                  layout: "baseline",
                  spacing: "sm",
                  contents: [
                    {
                      type: "text",
                      text: "内容",
                      color: "#aaaaaa",
                      size: "sm",
                      flex: 1
                    },
                    {
                      type: "text",
                      text: content,
                      wrap: true,
                      color: "#666666",
                      size: "sm",
                      flex: 5
                    }
                  ]
                }
              ]
            }
          ]
        }
      }

      deliveries.each do |delivery|
        line_client.push_flex_message(delivery.user.uid, "新しい投稿があります: #{title}", flex_contents)
      end
    end

  def schedule_publication
    # `published_at`が設定されていれば予約投稿、そうでなければ即時投稿
    if published_at.present?
      PublishPostJob.set(wait_until: published_at).perform_later(self)
    else
      update(published: true)
      notify_line
    end
  end
end
