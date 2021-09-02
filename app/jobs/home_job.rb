class HomeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Product.create(name: 'Test Sidekiq', price: 20, description: 'Testing 1 2 3...')
  end
end
