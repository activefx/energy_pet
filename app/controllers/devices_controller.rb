class DevicesController < ApplicationController

  before_filter :authenticate_user!

  def index
    binding.pry
    @user = current_user
  end
end

