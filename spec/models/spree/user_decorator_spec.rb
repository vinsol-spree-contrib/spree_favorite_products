require 'spec_helper'

describe Spree::User do
  before(:each) do
    @user = Spree::User.create! email: 'test@example.com', password: 'spree123'
    shipping_category = Spree::ShippingCategory.create! name: 'shipping_category'
    @product1 = Spree::Product.create! name: 'product1', price: 100, shipping_category_id: shipping_category.id
    @product2 = Spree::Product.create! name: 'product2', price: 100, shipping_category_id: shipping_category.id
    favorite = Spree::Favorite.new
    favorite.favoritable_id = @product1.id
    favorite.favoritable_type = 'Spree::Product'
    favorite.user_id = @user.id
    favorite.save!
  end

  it { is_expected.to have_many(:favorites).dependent(:destroy) }
  it { is_expected.to have_many(:favorite_products).through(:favorites).source(:favoritable) }
  it { is_expected.to have_many(:favorite_variants).through(:favorites).source(:favoritable) }

  describe "#has_favorite_product?" do
    context "when product in user's favorite products" do
      it { expect(@user.has_favorite_product?(@product1.id)).to be_truthy }
    end

    context 'when product is not in users favorite products' do
      it { expect(@user.has_favorite_product?(@product2.id)).to be_falsey }
    end
  end

  describe '#has_favorite_variant?' do
    before(:each) do
      option_type = Spree::OptionType.new presentation: 'Size', name: 'size'
      option_type.save!

      option_value = Spree::OptionValue.new presentation: 'Large', name: 'large', option_type_id: Spree::OptionType.last.id
      option_value.save!

      @variant = Spree::Variant.new product_id: Spree::Product.first.id
      @variant.option_values << Spree::OptionValue.first
      @variant.save!

      @fav_variant = Spree::Variant.new product_id: Spree::Product.second.id
      @fav_variant.option_values << Spree::OptionValue.first
      @fav_variant.save!

      favorite = Spree::Favorite.new user_id: Spree::User.first.id, favoritable_id: @fav_variant.id, favoritable_type: 'Spree::Variant'
      favorite.save!
    end

    context "when variant is present in user's favorite_variants" do
      it { expect(@user.has_favorite_variant?(@fav_variant.id)).to be_truthy }
    end

    context "when variant is not present in user's favorite_variants" do
      it { expect(@user.has_favorite_variant?(@variant.id)).to be_falsey }
    end
  end
end
