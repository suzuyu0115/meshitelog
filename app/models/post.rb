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

  acts_as_taggable

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

  scope :with_associations, -> { includes(:deliveries, :recipients, :comments, :bookmarks) }
  scope :tag_name_cont, ->(tag_name) { tagged_with(tag_name) }

  ROOT_URL = "https://meshitelog.com"

  def self.ransackable_scopes(_auth_object = nil)
    [:tag_name_cont]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["bookmarks", "comments", "user"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["content", "created_at", "title"]
  end

  def future_reserved_post?(current_user)
    published_at.present? && published_at > Time.current && user != current_user
  end

  # nicknameがあればnicknameを、なければnameを返す
  def sender_name
    user.nickname || user.name
  end

  # 各投稿詳細ページのURLを返す
  def post_url
    "#{ROOT_URL}/posts/#{id}"
  end

  def notify_line
    # 予約投稿か否かを判定
    return unless published?

    line_client = LineClient.new
    flex_contents = {
      type: "bubble",
      header: {
        type: 'box',
        layout: 'vertical',
        contents: [
          {
            type: 'text',
            text: "飯が届きました！",
            weight: "bold",
            size: "xl",
            wrap: true
          }
        ]
      },
      hero: {
        type: "image",
        url: food_image.url,
        size: "full",
        aspectRatio: "20:13",
        aspectMode: "cover",
        action: {
          type: "uri",
          uri: post_url
        }
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "text",
            text: title,
            weight: "bold",
            size: "xl",
            wrap: true
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
                    text: "#{sender_name} さんより",
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
                    text: content,
                    wrap: true,
                    color: "#666666",
                    size: "md",
                    flex: 5
                  }
                ]
              }
            ]
          }
        ]
      },
      footer: {
        type: "box",
        layout: "vertical",
        spacing: "sm",
        contents: [
          {
            type: "button",
            style: "link",
            height: "sm",
            action: {
              type: "uri",
              label: "詳細を見る",
              uri: post_url
            }
          },
          {
            type: "box",
            layout: "vertical",
            contents: [],
            margin: "sm"
          }
        ],
        flex: 0
      }
    }

    deliveries.each do |delivery|
      line_client.push_flex_message(delivery.user.line_user_id, "飯が届きました！： #{title}", flex_contents)
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
