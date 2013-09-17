require 'spec_helper'

describe Spree::User do
  it { should have_many(:favorites) }
  it { should have_many(:favorite_products).through(:favorites).class_name('Spree::Product') }
end