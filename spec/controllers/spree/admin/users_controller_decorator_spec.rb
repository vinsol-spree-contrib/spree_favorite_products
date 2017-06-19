require "spec_helper"

RSpec.describe Spree::Admin::UsersController, type: :controller do
  let(:user) { mock_model(Spree::User) }
  let(:favorite_product) { mock_model(Spree::Product) }
  let(:favorite_products) { double(ActiveRecord::Relation) }

  describe 'favorite_products' do
    stub_authorization!

    def send_request
      get :favorite_products, params: { id: user.id }
    end


    before do
      allow(Spree::User).to receive(:find).and_return(user)
      allow(user).to receive(:favorite_products).and_return(favorite_products)
      allow(favorite_products).to receive_message_chain(:page, :per).and_return(favorite_products)
    end

    it 'is expected to set favorite_products' do
      expect(user).to receive(:favorite_products).and_return(favorite_products)
      send_request
    end

  end
end
