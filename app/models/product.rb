class Product < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :colors
  has_many :product_items
  has_many :cart_items
  has_many :product_images
end
