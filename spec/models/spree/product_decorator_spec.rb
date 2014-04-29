require 'spec_helper'

describe Spree::Product do
  before(:each) do
    shipping_category = Spree::ShippingCategory.create! :name => 'shipping_category'
    @favorite_product1 = Spree::Product.create! :name => 'favorite_product1', :price => 100, :shipping_category_id => shipping_category.id
    @favorite_product2 = Spree::Product.create! :name => 'favorite_product2', :price => 100, :shipping_category_id => shipping_category.id
    @product1 = Spree::Product.create! :name => 'product1', :price => 100, :shipping_category_id => shipping_category.id
    @product2 = Spree::Product.create! :name => 'product2', :price => 100, :shipping_category_id => shipping_category.id
    @user1 = Spree::User.create! :email => 'user1@example.com', :password => 'example', :password_confirmation => "example"
    @user2 = Spree::User.create! :email => 'user2@example.com', :password => "example", :password_confirmation => 'example'
    @user1.favorites.create! :product_id => @favorite_product1.id
    @user2.favorites.create! :product_id => @favorite_product1.id
    @user2.favorites.create! :product_id => @favorite_product2.id
  end

  it { should have_many(:favorites) }
  it { should have_many(:favorite_users).through(:favorites).class_name('Spree::User') }

  describe "Spree::Product.favorite" do
    it "returns favorite products" do
      Spree::Product.favorite.should =~ [@favorite_product1, @favorite_product2]
    end
  end

  describe ".order_by_favorite_users_count" do
    context 'when order not passed' do
      it "returns products ordered by users_count in descending order" do
        Spree::Product.favorite.order_by_favorite_users_count.should eq([@favorite_product1, @favorite_product2])
      end
    end

    context 'when asc order passed' do
      it "returns products ordered by users_count in ascending order" do
        Spree::Product.favorite.order_by_favorite_users_count(true).should eq([@favorite_product2, @favorite_product1])
      end
    end
  end
end