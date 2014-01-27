require 'spec_helper'

describe Spree::FavoriteProductsController do

  shared_examples_for "request which requires user authentication" do
    it "authenticates user" do
      controller.should_receive(:authenticate_spree_user!)
      send_request      
    end
  end

  shared_examples_for "request which finds favorite product" do
    it "finds favorite product" do
      @current_user_favorites.should_receive(:where).with(:spree_products => {:permalink => 'permalink'})
      send_request
    end

    it "assigns @favorite" do
      send_request
      assigns(:favorite).should eq(@favorite)
    end
  end

  describe 'POST create' do
    def send_request
      post :create, :id => 1, :format => :js, :use_route => 'spree'
    end

    before(:each) do
      @favorite = mock_model(Spree::Favorite, :save => true)
      controller.stub(:authenticate_spree_user!).and_return(true)
      Spree::Favorite.stub(:new).and_return(@favorite)
      @user = mock_model(Spree::User, :favorites => Spree::Favorite, :generate_spree_api_key! => false, :last_incomplete_spree_order => nil)
      controller.stub(:spree_current_user).and_return(@user)
    end

    it_behaves_like "request which requires user authentication"

      
    it "creates favorite" do
      Spree::Favorite.should_receive(:new).with(:product_id => 1)
      send_request
    end

    it "saves favorite" do
      @favorite.should_receive(:save)
      send_request
    end

    context "when favorite saved successfully" do
      it "renders create" do
        send_request
        response.should render_template(:create)
      end

      it "should assign success message" do
        send_request
        assigns(:message).should eq("Product has been successfully marked as favorite")
      end
    end

    context "when favorite not saved sucessfully" do
      before(:each) do
        @favorite.stub(:save).and_return(false)
        @favorite.stub_chain(:errors, :full_messages).and_return(["Product already marked as favorite"])
      end

      it "renders create template" do
        send_request
        response.should render_template(:create)
      end

      it "should assign error message" do
        send_request
        assigns(:message).should eq("Product already marked as favorite")
      end
    end
  end

  describe 'GET index' do
    def send_request
      get :index, :use_route => 'spree'
    end

    before(:each) do
      @favorite_product = mock_model(Spree::Product)
      @user = mock_model(Spree::User, :favorite_products => [@favorite_product], :generate_spree_api_key! => false, :last_incomplete_spree_order => nil)
      controller.stub(:authenticate_spree_user!).and_return(true)
      controller.stub(:spree_current_user).and_return(@user)
    end

    it "authenticates user" do
      controller.should_receive(:authenticate_spree_user!)
      send_request
    end

    it "finds favorite products of current user" do
      @user.should_receive(:favorite_products)
      send_request
    end

    it "assigns @favorite_products" do
      send_request
      assigns(:favorite_products).should eq([@favorite_product])
    end
  end

  describe 'destroy' do
    def send_request(params = {})
      post :destroy, params.merge({:use_route => 'spree', :method => :delete, :format => :js, :id => 'permalink'})
    end

    before do
      @favorite = mock_model(Spree::Favorite)
      @current_user_favorites = double('spree_favorites')
      @current_user_favorites.stub(:where).and_return([@favorite])
      @favorites = double('spree_favorites')
      @favorites.stub(:joins).with(:product).and_return(@current_user_favorites)
      @user = mock_model(Spree::User, :favorites => @favorites, :generate_spree_api_key! => false, :last_incomplete_spree_order => nil)
      controller.stub(:authenticate_spree_user!).and_return(true)
      controller.stub(:spree_current_user).and_return(@user)
    end

    it_behaves_like "request which requires user authentication"
    it_behaves_like "request which finds favorite product"

    context 'when @favorite  exist' do
      before(:each) do
        controller.instance_variable_set(:@favorite, @favorite)
      end

      it 'destroys' do
        @favorite.should_receive(:destroy)
        send_request
      end

      context 'when destroyed successfully' do
        before(:each) do
          @favorite.stub(:destroy).and_return(true)
        end

        it "sets @success to true" do
          send_request
          assigns(:success).should eq(true)
        end 
      end

      context 'when not destroyed' do
        before(:each) do
          @favorite.stub(:destroy).and_return(false)
        end

        it 'sets @success to false' do
          send_request
          assigns(:success).should eq(false)
        end
      end
    end

  end
end