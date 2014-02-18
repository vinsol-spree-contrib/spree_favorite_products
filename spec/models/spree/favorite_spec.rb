require 'spec_helper'

describe Spree::Favorite do
  it { should belong_to(:product) }
  it { should belong_to(:user) }
  it { should validate_uniqueness_of(:product_id).scoped_to(:user_id).with_message("already marked as favorite") }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:product_id) }

  context "when product_id is present" do
    before(:each) do
      @favorite = Spree::Favorite.new :product_id => 'invalid product id'
    end
    it "checks for the presence of product" do
      @favorite.valid?
      @favorite.errors[:product].should eq(["is invalid"])
    end
  end

  context "when product_id is not present" do
    before(:each) do
      @favorite = Spree::Favorite.new
    end

    it "does not validate the presence of product" do
      @favorite.valid?
      @favorite.errors[:product].should eq([])
    end
  end
end