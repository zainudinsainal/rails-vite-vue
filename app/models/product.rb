class Product < ApplicationRecord
  validates :name, :price, presence: true

  after_create :notify_new_product

  private

  def notify_new_product
    UserMailer.new_product_email(self).deliver_later
  end
end
