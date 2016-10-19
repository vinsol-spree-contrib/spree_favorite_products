require 'spec_helper'

describe Spree::Favorite do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:product_id).scoped_to(:user_id).with_message("already marked as favorite") }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:product_id) }

  context "when product_id is present" do
    before(:each) do
      @favorite = Spree::Favorite.new :product_id => 'invalid product id'
    end
    it "checks for the presence of product" do
      @favorite.valid?
      expect(@favorite.errors[:product]).to eq(["is invalid"])
    end
  end

  context "when product_id is not present" do
    before(:each) do
      @favorite = Spree::Favorite.new
    end

    it "does not validate the presence of product" do
      @favorite.valid?
      expect(@favorite.errors[:product]).to eq([])
    end
  end
end