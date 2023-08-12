# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  avatar       :string
#  name         :string           not null
#  nickname     :string
#  role         :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  line_user_id :string           not null
#
# Indexes
#
#  index_users_on_line_user_id  (line_user_id) UNIQUE
#
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :posts, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  has_many :received_posts, through: :deliveries, source: :post
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post

  validates :name, presence: true

  enum role: { general: 0, admin: 1 }

  scope :with_associations, -> { includes(:posts, :deliveries, :received_posts, :comments, :bookmarks, :bookmark_posts) }

  # current_userか否かを判別するロジック
  def own?(object)
    object.user_id == id
  end

  # ブックマークに追加する
  def bookmark(post)
    bookmark_posts << post
  end

  # ブックマークを外す
  def unbookmark(post)
    bookmark_posts.destroy(post)
  end

  # ブックマークをしているか判定する
  def bookmark?(post)
    bookmark_posts.include?(post)
  end

  # nicknameが存在すればそれを返し、なければnameを返す
  def display_name
    nickname.presence || name
  end
end
