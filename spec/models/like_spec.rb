require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create( :user ) }
  let(:bookmark) { create( :bookmark ) }
  let(:like) { Like.create!(bookmark: bookmark, user: user) }

  it { is_expected.to belong_to(:bookmark) }
  it { is_expected.to belong_to(:user) }
end
