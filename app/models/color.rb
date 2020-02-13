class Color < ApplicationRecord
  has_and_belongs_to_many :products
  has_many :product_items
end
