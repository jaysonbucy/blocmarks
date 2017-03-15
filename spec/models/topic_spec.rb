require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { is_expected.to belong_to(:user) }
end
