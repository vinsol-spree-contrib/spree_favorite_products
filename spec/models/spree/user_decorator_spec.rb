require 'spec_helper'

describe Spree::User do
  before(:each) do
    shipping_category =  Spree::ShippingCategory.new
    shipping_category.save(validate: false)
    @user = Spree::User.create! email: 'test@example.com', :password => 'spree123'
    @product1 = Spree::Product.create! name: 'product1', price: 100, shipping_category_id: shipping_category.id
    @product2 = Spree::Product.create! name: 'product2', price: 100, shipping_category_id: shipping_category.id
    favorite = Spree::Favorite.new
    favorite.product_id = @product1.id
    favorite.user_id = @user.id
    favorite.save!
  end

  it { should have_many(:favorites).dependent(:destroy) }
  it { should have_many(:favorite_products).through(:favorites).class_name('Spree::Product') }

  describe "has_favorite_product?" do
    context "when product in user's favorite products" do
      it { @user.has_favorite_product?(@product1.id).should be_true }
    end

    context 'when product is not in users favorite products' do
      it { @user.has_favorite_product?(@product2.id).should be_false }
    end
  end
end
