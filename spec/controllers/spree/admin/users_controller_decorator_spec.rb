require "spec_helper"

RSpec.describe Spree::Admin::UsersController, type: :controller do
  let(:role) { Spree::Role.create!(name: 'user') }
  let(:roles) { [role] }
  let(:user) { mock_model(Spree::User, generate_spree_api_key!: false) }
  let(:favorite_product) { mock_model(Spree::Product) }
  let(:favorite_products) { double(ActiveRecord::Relation) }
  let(:proxy_object) { Object.new }


  describe 'favorite_products' do
    stub_authorization!

    def send_request
      get :favorite_products, id: user.id
    end


    before do
      allow(user).to receive(:roles).and_return(proxy_object)
      allow(proxy_object).to receive(:includes).and_return([])

      allow(user).to receive(:has_spree_role?).with('admin').and_return(true)
      allow(controller).to receive(:spree_user_signed_in?).and_return(true)
      allow(controller).to receive(:spree_current_user).and_return(user)
      allow(user).to receive(:roles).and_return(roles)
      allow(roles).to receive(:includes).with(:permissions).and_return(roles)

      allow(controller).to receive(:authorize_admin).and_return(true)
      allow(controller).to receive(:authorize!).and_return(true)

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
