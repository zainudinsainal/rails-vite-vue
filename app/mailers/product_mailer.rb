class ProductMailer < ApplicationMailer

  def image_upload_email(product)
    @product = product
    mail(to: 'devops@payboy.biz', subject: '[Test Mail] New product')
  end
end
