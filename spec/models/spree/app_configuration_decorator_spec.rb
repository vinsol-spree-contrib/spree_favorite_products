describe Spree::AppConfiguration do
  it { Spree::Config.favorite_products_per_page.should eq 10 }
end