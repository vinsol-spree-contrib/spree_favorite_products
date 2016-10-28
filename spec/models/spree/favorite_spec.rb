require 'spec_helper'

describe Spree::Favorite do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:product_id).scoped_to(:user_id).with_message("already marked as favorite") }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:product) }

  describe ".with_product_id" do
    before(:each) do
      shipping_category = Spree::ShippingCategory.create! name: 'shipping_category'
      @favorite_product1 = Spree::Product.create! name: 'favorite_product1', price: 100, shipping_category_id: shipping_category.id
      @favorite_product2 = Spree::Product.create! name: 'favorite_product2', price: 100, shipping_category_id: shipping_category.id
      @product1 = Spree::Product.create! name: 'product1', price: 100, shipping_category_id: shipping_category.id
      @product2 = Spree::Product.create! name: 'product2', price: 100, shipping_category_id: shipping_category.id
      @user1 = Spree::User.create! email: 'user1@example.com', password: 'example', password_confirmation: "example"
      @user2 = Spree::User.create! email: 'user2@example.com', password: "example", password_confirmation: 'example'
      @favorite1 = @user1.favorites.create! product_id: @favorite_product1.id
      @favorite2 = @user2.favorites.create! product_id: @favorite_product1.id
      @favorite3 = @user2.favorites.create! product_id: @favorite_product2.id
    end

    it "expects to list favorites with given product id" do
      expect(Spree::Favorite.with_product_id(@favorite_product1.id)).to include(@favorite1, @favorite2)
    end

    it "expects not to list favorites with other product id" do
      expect(Spree::Favorite.with_product_id(@favorite_product1.id)).not_to include(@favorite3)
    end
  end
end
