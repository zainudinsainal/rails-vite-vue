class Api::ApiController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def meta_attributes(collection, extra_meta = {})
    {
      pagination: pagy_metadata(collection)
    }.merge(extra_meta)
  end
end
