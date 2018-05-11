require 'spec_helper'

describe Spree::Admin::FavoriteVariantsController do
  let(:role) { Spree::Role.create!(name: 'user') }
  let(:roles) { [role] }
  let(:variant) { mock_model( Spree::Variant) }
  let(:proxy_object) { Object.new }

  before(:each) do
    @user = mock_model(Spree::User, generate_spree_api_key!: false)
    allow(@user).to receive(:roles).and_return(proxy_object)
    allow(proxy_object).to receive(:includes).and_return([])

    allow(@user).to receive(:has_spree_role?).with('admin').and_return(true)
    allow(controller).to receive(:spree_user_signed_in?).and_return(true)
    allow(controller).to receive(:spree_current_user).and_return(@user)
    allow(@user).to receive(:roles).and_return(roles)
    allow(roles).to receive(:includes).with(:permissions).and_return(roles)
    allow(controller).to receive(:authorize_admin).and_return(true)
    allow(controller).to receive(:authorize!).and_return(true)

    @favorite_variants = double('favorite_variants')
    allow(@favorite_variants).to receive(:includes).and_return(@favorite_variants)
    allow(@favorite_variants).to receive(:order_by_favorite_users_count).and_return(@favorite_variants)
    allow(@favorite_variants).to receive(:joins).and_return(@favorite_variants)
    @search = double('search', result: @favorite_variants)
    allow(@favorite_variants).to receive(:search).and_return(@search)
    allow(@favorite_variants).to receive(:page).and_return(@favorite_variants)
    allow(@favorite_variants).to receive(:per).and_return(@favorite_variants)
    allow(Spree::Variant).to receive(:favorite).and_return(@favorite_variants)
  end

  describe "GET index" do
    def send_request
      get :index, params: { page: 1, q: { s: 'name desc' } }
    end

    it "returns favorite variants" do
      expect(Spree::Variant).to receive(:favorite)
      send_request
    end

    it "searches favorite variants" do
      search_params = ActionController::Parameters.new(s: 'name desc')
      expect(@favorite_variants).to receive(:search).with(search_params)
      send_request
    end

    it "assigns @search" do
      send_request
      expect(assigns(:search)).to eq(@search)
    end

    context 'when order favorite variants by users count in asc order' do
      def send_request
        get :index, params: { page: 1, q: { s: 'favorite_users_count asc' } }
      end

      it "orders favorite variants by users count in asc order" do
        expect(@favorite_variants).to receive(:order_by_favorite_users_count).with(true)
        send_request
      end
    end

    context 'when order favorite variants by users count in desc order' do
      it "orders favorite variants by users count in asc order" do
        expect(@favorite_variants).to receive(:order_by_favorite_users_count).with(false)
        send_request
      end
    end

    it "paginates favorite variants" do
      expect(@favorite_variants).to receive(:page).with("1")
      send_request
    end

    it "renders favorite variants template" do
      send_request
      expect(response).to render_template(:index)
    end
  end

  describe "#sort_in_ascending_users_count?" do

    context 'when favorite_user_count asc present in params[q][s]' do
      def send_request
        get :index, params: { page: 1, q: { s: 'favorite_users_count asc' } }
      end

      it "is true" do
        expect(controller.send(:sort_in_ascending_users_count?)).to be true
      end

      before do
        send_request
      end
    end

    context 'when favorite_user_count not present in params' do
      def send_request
        get :index, params: { page: 1, q: { s: 'name asc' } }
      end

      it "is false" do
        expect(controller.send(:sort_in_ascending_users_count?)).to be false
      end

      before do
        send_request
      end
    end
  end
end
