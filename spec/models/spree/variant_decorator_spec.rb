require 'spec_helper'

describe Spree::Variant do

  before(:each) do
    option_type = Spree::OptionType.new presentation: 'Size', name: 'size'
    option_type.save!

    option_value = Spree::OptionValue.new presentation: 'Large', name: 'large', option_type_id: Spree::OptionType.last.id
    option_value.save!

    shipping_category = Spree::ShippingCategory.create! name: 'shipping_category'
    Spree::Product.create! name: 'product1', price: 100, shipping_category_id: shipping_category.id
    Spree::Product.create! name: 'product2', price: 700, shipping_category_id: shipping_category.id

    @variant1 = Spree::Variant.new product_id: Spree::Product.first.id
    @variant1.option_values << Spree::OptionValue.first
    @variant1.save!

    @variant2 = Spree::Variant.new product_id: Spree::Product.second.id
    @variant2.option_values << Spree::OptionValue.first
    @variant2.save!

    @user1 = Spree::User.create! email: 'user1@example.com', password: 'example', password_confirmation: "example"
    @user2 = Spree::User.create! email: 'user2@example.com', password: "example", password_confirmation: 'example'
    @user1.favorites.create! favoritable_id: @variant1.id, favoritable_type: 'Spree::Variant'
    @user2.favorites.create! favoritable_id: @variant1.id, favoritable_type: 'Spree::Variant'
    @user2.favorites.create! favoritable_id: @variant2.id, favoritable_type: 'Spree::Variant'
  end

  describe 'Associations' do
    it { is_expected.to have_many(:favorites).dependent(:destroy) }
    it { is_expected.to have_many(:favorite_users).through(:favorites).class_name('Spree::User') }
  end

  describe "favorite" do
    it "returns favorite variants" do
      expect(Spree::Variant.favorite).to match_array([@variant1, @variant2])
    end
  end

  describe "order_by_favorite_users_count" do
    context 'when order not passed' do
      it "returns variants ordered by favorite_users_count in descending order" do
        expect(Spree::Variant.favorite.order_by_favorite_users_count).to eq([@variant1, @variant2])
      end
    end

    context 'when asc order passed' do
      it "returns variants ordered by favorite_users_count in ascending order" do
        expect(Spree::Variant.favorite.order_by_favorite_users_count(true)).to eq([@variant2, @variant1])
      end
    end
  end

end