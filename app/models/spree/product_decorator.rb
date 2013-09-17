Spree::Product.class_eval do
  has_many :favorites
  has_many :favorite_users, :through => :favorites, :class_name => 'Spree::User', :source => 'user'

  def self.favorite
    joins(:favorites).uniq
  end
end