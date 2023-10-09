require 'rails_helper'

RSpec.describe User, type: :model do
  # ファクトリが正しく動作することを確認
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  # バリデーションのテスト
  describe "validations" do
    it "requires a name" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors.messages[:name]).to include("を入力してください")
    end

    it "requires a unique line_user_id" do
      create(:user, line_user_id: "unique_id")
      user = build(:user, line_user_id: "unique_id")
      expect(user).not_to be_valid
      expect(user.errors.messages[:line_user_id]).to include("はすでに存在します")
    end
  end

  # # アソシエーションのテスト
  describe "associations" do
    it { should have_many(:posts).dependent(:destroy) }
  #   it { should have_many(:deliveries).dependent(:destroy) }
  #   it { should have_many(:received_posts).through(:deliveries) }
  #   it { should have_many(:comments).dependent(:destroy) }
  #   it { should have_many(:bookmarks).dependent(:destroy) }
  #   it { should have_many(:bookmark_posts).through(:bookmarks) }
  end

  # enumのテスト
  describe "enum role" do
    it "can be 'general'" do
      user = create(:user, role: "general")
      expect(user.general?).to be_truthy
    end

    it "can be 'admin'" do
      user = create(:user, role: "admin")
      expect(user.admin?).to be_truthy
    end
  end

  # # スコープのテスト
  # describe ".with_associations" do
  #   let!(:user) { create(:user) }
  #   it "preloads the specified associations" do
  #     expect(User).to receive(:includes).with(
  #       :posts, :deliveries, :received_posts, :comments, :bookmarks, :bookmark_posts
  #     )
  #     User.with_associations
  #   end
  # end
end
