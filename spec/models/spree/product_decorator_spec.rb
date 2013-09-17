require 'spec_helper'

describe Spree::Product do
  it { should have_many(:favorites) }
  it { should have_many(:favorite_users).through(:favorites).class_name('Spree::User') }

  describe "Spree::Product.favorite" do
    before(:each) do
      @favorite_product1 = Spree::Product.create! :name => 'favorite_product1', :price => 100
      @favorite_product2 = Spree::Product.create! :name => 'favorite_product2', :price => 100
      @product1 = Spree::Product.create! :name => 'product1', :price => 100
      @product2 = Spree::Product.create! :name => 'product2', :price => 100
      @user1 = Spree::User.create! :email => 'user1@example.com', :password => 'example', :password_confirmation => "example"
      @user2 = Spree::User.create! :email => 'user2@example.com', :password => "example", :password_confirmation => 'example'
      @user1.favorites.create! :product_id => @favorite_product1.id
      @user2.favorites.create! :product_id => @favorite_product1.id
      @user2.favorites.create! :product_id => @favorite_product2.id
    end

    it "returns favorite products" do
      Spree::Product.favorite.should =~ [@favorite_product1, @favorite_product2]
    end
  end
end