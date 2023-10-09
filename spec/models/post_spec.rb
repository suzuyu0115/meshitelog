require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:post)).to be_valid
    end
  end

  describe 'Validations' do
    it 'requires a title' do
      post = build(:post, title: nil)
      expect(post).not_to be_valid
      expect(post.errors.messages[:title]).to include("を入力してください")
    end

    it 'requires content' do
      post = build(:post, content: nil)
      expect(post).not_to be_valid
      expect(post.errors.messages[:content]).to include("を入力してください")
    end

    it 'restricts the title length' do
      post = build(:post, title: 'a' * 256)
      expect(post).not_to be_valid
      expect(post.errors.messages[:title]).to include("は255文字以内で入力してください")
    end

    it 'restricts the content length' do
      post = build(:post, content: 'a' * 65_536)
      expect(post).not_to be_valid
      expect(post.errors.messages[:content]).to include("は65535文字以内で入力してください")
    end
  end
end
