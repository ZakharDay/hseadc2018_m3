class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :color
  has_many :cart_items
end
