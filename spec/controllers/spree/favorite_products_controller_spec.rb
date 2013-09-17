require 'spec_helper'

describe Spree::FavoriteProductsController do

  shared_examples_for "request which requires user authentication" do
    it "authenticates user" do
      controller.should_receive(:authenticate_spree_user!)
      send_request      
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
      post :destroy, params.merge({:use_route => 'spree', :method => :delete, :format => :js})
    end

    before do
      @favorite_product = mock_model(Spree::Favorite)
      @product = mock_model(Spree::Product, :permalink => 'my_product', :id => 100)
      @user = mock_model(Spree::User, :favorite_products => [@favorite_product], :generate_spree_api_key! => false, :last_incomplete_spree_order => nil)
      controller.stub(:authenticate_spree_user!).and_return(true)
      controller.stub(:spree_current_user).and_return(@user)
    end

    it_behaves_like "request which requires user authentication"

    context 'when favorite product entry for the requested product exits' do
      before do
        Spree::Product.stub(:where).with(:permalink => @product.permalink).and_return([@product])
        Spree::Favorite.stub(:where).with("user_id = ? and product_id = ?", @user.id, 100).and_return([@favorite_product])
      end

      it 'assigns its id to product_id' do
        send_request(:id => @product.permalink)
        assigns(:product_id).should eq(100)
      end

      it 'assigns favorite product object to favorite_product' do
        send_request(:id => @product.permalink)
        assigns(:favorite_product).should eq(@favorite_product)
      end

      it 'calls for destroy on the favorite_product' do
        @favorite_product.should_receive(:destroy)        
        send_request(:id => @product.permalink)
      end 

      context 'and is destroyed successfully' do
        before do
          @favorite_product.stub(:destroy).and_return(true)
        end

        it 'assigns true to success' do
          send_request(:id => @product.permalink)
          assigns(:success).should be_true
        end
      end

      context 'and is not destroyed successfully' do
        before do
          @favorite_product.stub(:destroy).and_return(false)
        end

        it 'assigns false to success' do
          send_request(:id => @product.permalink)
          assigns(:success).should be_false
        end
      end
    end

    context 'when favorite product entry for the requested product does not exit' do
      before do
        Spree::Product.stub(:where).with(:permalink => @product.permalink).and_return([])
      end

      it 'does not assign any id to product_id' do
        send_request(:id => @product.permalink)
        assigns(:product_id).should be_nil
      end

      it 'assigns favorite product object to favorite_product' do
        send_request(:id => @product.permalink)
        assigns(:favorite_product).should be_nil
      end

      it 'calls for destroy on the favorite_product' do
        send_request(:id => @product.permalink)
        @favorite_product.should_not_receive(:destroy)        
      end

      it 'assigns false to success' do
        send_request(:id => @product.permalink)
        assigns(:success).should be_false
      end 
    end
  end
end