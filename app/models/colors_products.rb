class ColorsProducts < ApplicationRecord
  belongs_to :color
  belongs_to :product
end
