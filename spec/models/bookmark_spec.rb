require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  it "has a valid factory" do
    expect(build(:bookmark)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
