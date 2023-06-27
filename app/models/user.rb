# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
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
  validates :name, presence: true
  validates :provider, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
    end
  end
end
