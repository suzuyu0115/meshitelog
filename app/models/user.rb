# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  avatar     :string
#  name       :string           not null
#  nickname   :string
#  provider   :string           not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :posts, dependent: :destroy
  has_many :deliveries
  has_many :received_posts, through: :deliveries, source: :post
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post

  validates :name, presence: true
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]

    user = find_or_initialize_by(provider:, uid:)
    user.name = name
    user.save ? user : nil
  end

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
end
