require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { create(:user) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@blocipedia.com").for(:email) }
  it { is_expected.to validate_presence_of(:password) }

  describe "attributes" do
    it "should have email attribute" do
      expect(user).to have_attributes(email: user.email)
    end

    it "should have username attribute" do
      expect(user).to have_attributes(username: user.username)
    end
  end
end
