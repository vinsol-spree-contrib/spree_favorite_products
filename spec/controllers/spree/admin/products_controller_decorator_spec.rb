require "spec_helper"

RSpec.describe Spree::Admin::ProductsController, type: :controller do

  let!(:user) { Spree::User.create! email: 'user1@example.com', password: 'example', password_confirmation: "example" }
  let!(:shipping_category) { Spree::ShippingCategory.create! name: 'shipping_category' }
  let!(:product) { Spree::Product.create! name: 'product1', price: 100, shipping_category_id: shipping_category.id }
  let!(:option_type) { Spree::OptionType.create! presentation: 'Size', name: 'size' }
  let!(:option_value) { Spree::OptionValue.new presentation: 'Large', name: 'large', option_type_id: option_type.id }
  let!(:variant) do
    variant = Spree::Variant.new product_id: product.id
    variant.option_values << option_value
    variant.save!
    variant
  end
  let!(:favorite_product) { Spree::Favorite.create! favoritable_id: product.id, favoritable_type: 'Spree::Product', user_id: user.id }
  let!(:favorite_variant) { Spree::Favorite.create! favoritable_id: variant.id, favoritable_type: 'Spree::Variant', user_id: user.id }

  describe 'GET users' do
    stub_authorization!

    describe 'it is expected to use set_variant' do
      before do
        get :favorite_users, params: { id: product.id }
      end

      it { is_expected.to use_before_action(:set_variant) }
    end

    context 'when params of type is product' do
      before do
        get :favorite_users, params: { id: product.id, type: 'product' }
      end

      it 'is expected to set @favorite_product_users' do
        expect(assigns(:favorite_product_users)).to include(user)
      end
    end

    context 'when params of type is variant' do
      before do
        get :favorite_users, params: { id: product.id, type: 'variant', item_id: variant.id }
      end

      it 'is expected to set @favorite_variant_users' do
        expect(assigns(:favorite_variant_users)).to include(user)
      end
    end

    context 'when param of type is not provided' do
      before do
        get :favorite_users, params: { id: product.id }
      end

      it 'is expected to set @favorite_product_users' do
        expect(assigns(:favorite_product_users)).to include(user)
      end

      it 'is expected to set @favorite_variant_users' do
        expect(assigns(:favorite_variant_users)).to include(user)
      end
    end
  end

  describe '#set_variant' do
    stub_authorization!

    context 'when params of type is variant' do
      context 'when variant id is valid' do
        before do
          get :favorite_users, params: { id: product.id, type: 'variant', item_id: variant.id }
        end

        it 'is expected to set @variant' do
          expect(assigns(:variant)).to eq(variant)
        end
      end

      context 'when variant id is not valid' do
        before do
          get :favorite_users, params: { id: product.id, type: 'variant', item_id: 'wrong_id' }
        end

        it 'is expected not to set @variant' do
          expect(assigns(:variant)).to eq(nil)
        end

        it { is_expected.to set_flash[:error].to('Variant does not exist') }

        it { is_expected.to redirect_to admin_products_path}
      end
    end
  end
end
