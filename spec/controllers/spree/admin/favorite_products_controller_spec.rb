require 'spec_helper'

describe Spree::Admin::FavoriteProductsController do
  let(:role) { Spree::Role.create!(:name => 'user') }
  let(:roles) { [role] }
  let(:product) { mock_model( Spree::Product) }

  before(:each) do
    @user = mock_model(Spree::User, :generate_spree_api_key! => false)
    @user.stub_chain(:roles, :includes).and_return([])
    @user.stub(:has_spree_role?).with('admin').and_return(true)
    controller.stub(:spree_user_signed_in?).and_return(true)
    controller.stub(:spree_current_user).and_return(@user)
    @user.stub(:roles).and_return(roles)
    roles.stub(:includes).with(:permissions).and_return(roles)
    controller.stub(:authorize_admin).and_return(true)
    controller.stub(:authorize!).and_return(true)
  end

  describe "GET index" do
    def send_request
      get :index, :page => 1 ,:use_route => 'spree'
    end

    before(:each) do
      @favorite_products = double('favorite_products')
      @favorite_products.stub(:page).and_return(@favorite_products)
      Spree::Product.stub(:favorite).and_return(@favorite_products)
    end

    it "returns favorite products" do
      Spree::Product.should_receive(:favorite)
      send_request
    end

    it "paginates favorite products" do
      @favorite_products.should_receive(:page).with("1")
      send_request
    end

    it "renders favorite products template" do
      send_request
      response.should render_template(:index)
    end
  end

  describe "#users" do
    before do
      @users = [@user]
      @users.stub(:page).and_return(@users)
      product.stub(:favorite_users).and_return(@users)
      @products = [product]
      Spree::Product.stub(:where).with(:id => product.id).and_return(@products)
    end

    def send_request
      get :users, :use_route => 'spree', :id => product.id, :format => :js
    end

    it 'fetches the product' do
      Spree::Product.should_receive(:where).with(:id => product.id).and_return(@products)
    end

    it 'fetches the users who marked the product as favorite' do
      product.should_receive(:favorite_users).and_return(@users)
    end

    after do
      send_request
    end
  end
end