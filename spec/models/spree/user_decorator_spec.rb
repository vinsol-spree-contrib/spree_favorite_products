require 'spec_helper'

describe Spree::User do
  before(:each) do
    @user = Spree::User.create! email: 'test@example.com', password: 'spree123'
    @product1 = Spree::Product.create! name: 'product1', price: 100, shipping_category_id: 1
    @product2 = Spree::Product.create! name: 'product2', price: 100, shipping_category_id: 1
    favorite = Spree::Favorite.new
    favorite.product_id = @product1.id
    favorite.user_id = @user.id
    favorite.save!
  end

  it { is_expected.to have_many(:favorites).dependent(:destroy) }
  it { is_expected.to have_many(:favorite_products).through(:favorites).class_name('Spree::Product') }

  describe "has_favorite_product?" do
    context "when product in user's favorite products" do
      it { expect(@user.has_favorite_product?(@product1.id)).to be_truthy }
    end

    context 'when product is not in users favorite products' do
      it { expect(@user.has_favorite_product?(@product2.id)).to be_falsey }
    end
  end
end