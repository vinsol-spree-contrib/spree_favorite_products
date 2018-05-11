require 'spec_helper'

describe Spree::Favorite do
  it { is_expected.to belong_to(:favoritable).counter_cache(:favorite_users_count) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:favoritable_id, :favoritable_type).with_message("already marked as favorite") }
  it { is_expected.to validate_presence_of(:user).with_message(:required) }
  it { is_expected.to validate_presence_of(:favoritable).with_message(:required) }
end
