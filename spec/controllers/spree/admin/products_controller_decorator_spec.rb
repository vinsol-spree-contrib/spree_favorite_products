require "spec_helper"

RSpec.describe Spree::Admin::ProductsController, type: :controller do

  describe 'GET users' do
    stub_authorization!
    let(:role) { Spree::Role.create!(name: 'user') }
    let(:roles) { [role] }
    let(:user) { mock_model(Spree::User, generate_spree_api_key!: false) }
    let(:product) { mock_model(Spree::Product, id: 10) }
    let(:favorite_product) { mock_model(Spree::Product) }
    let(:favorite_users) { double(ActiveRecord::Relation) }
    let(:proxy_object) { Object.new }


    def send_request
      get :favorite_users, id: product.id
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
