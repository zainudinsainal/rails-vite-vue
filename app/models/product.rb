class Product < ApplicationRecord
  validates :name, :price, presence: true

  mount_uploader :image, ImageUploader
end
