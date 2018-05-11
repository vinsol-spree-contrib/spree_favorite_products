require "spec_helper"

RSpec.describe Spree::Admin::UsersController, type: :controller do
  let(:user) { mock_model(Spree::User) }
  let(:favorite_product) { mock_model(Spree::Product) }
  let(:favorite_products) { double(ActiveRecord::Relation) }
  let(:favorite_variant) { mock_model(Spree::Variant) }
  let(:favorite_variants) { double(ActiveRecord::Relation) }

  describe 'favorite_products' do
    stub_authorization!

    def send_request
      get :favorite_products, params: { id: user.id }
    end


    before do
      allow(Spree::User).to receive(:find).and_return(user)
      allow(user).to receive(:favorite_products).and_return(favorite_products)
      allow(user).to receive(:favorite_variants).and_return(favorite_products)
    end

    it 'is expected to set favorite_products' do
      expect(user).to receive(:favorite_products).and_return(favorite_products)
      send_request
    end

    it 'is expected to set favorite_variants' do
      expect(user).to receive(:favorite_variants).and_return(favorite_variants)
      send_request
    end
  end
end
