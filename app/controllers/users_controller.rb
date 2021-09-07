class UsersController < ApplicationController
  def index
    gon.user = { name: 'John', role: 'Admin', id: '2' }
  end
end
