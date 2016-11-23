describe Spree::AppConfiguration do
  it { expect(Spree::Config.favorite_products_per_page).to eq 10 }
end
