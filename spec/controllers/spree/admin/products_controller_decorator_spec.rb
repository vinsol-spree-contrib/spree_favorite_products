require "spec_helper"

RSpec.describe Spree::Admin::ProductsController, type: :controller do

  describe 'GET users' do
    stub_authorization!
    let(:product) { mock_model(Spree::Product, id: 10) }
    let(:favorite_product) { mock_model(Spree::Product) }
    let(:favorite_users) { double(ActiveRecord::Relation) }

    def send_request
      get :favorite_users, params: { id: product.id }
    end


    before do
      allow(Spree::Product).to receive_message_chain( :with_deleted, :friendly, :find).and_return(product)
      allow(product).to receive(:favorite_users).and_return(favorite_users)
      allow(favorite_users).to receive_message_chain(:page, :per).and_return(favorite_users)
    end

    it 'is expected to set favorite_users' do
      expect(product).to receive(:favorite_users).and_return(favorite_users)
      send_request
    end

  end
end
