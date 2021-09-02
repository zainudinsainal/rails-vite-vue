class Admin::HomeController < ApplicationController

  def index
    render json: {"message": "Welcome hello"}
    HomeJob.perform_later
  end
end
