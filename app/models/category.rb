class Category < ApplicationRecord
  has_many :products
  mount_uploader :cover, CategoryCoverUploader
  validates :name, uniqueness: true
end
