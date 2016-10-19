require 'spec_helper'

describe Spree::Favorite do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:product_id).scoped_to(:user_id).with_message("already marked as favorite") }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:product) }
end
