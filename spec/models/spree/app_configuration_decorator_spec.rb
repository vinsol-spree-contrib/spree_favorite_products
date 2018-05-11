require 'spec_helper'

describe Spree::AppConfiguration do
  it { expect(Spree::Config.favorite_products_per_page).to eq 10 }
  it { expect(Spree::Config.favorite_users_per_page).to eq 10 }
end
