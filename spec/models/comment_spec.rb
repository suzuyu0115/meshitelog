require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end

  describe "validations" do
    it "requires a body" do
      comment = build(:comment, body: nil)
      expect(comment).not_to be_valid
      expect(comment.errors.messages[:body]).to include("を入力してください")
    end

    it "restricts the body length" do
      comment = build(:comment, body: 'a' * 65_536)
      expect(comment).not_to be_valid
      expect(comment.errors.messages[:body]).to include("は65535文字以内で入力してください")
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
