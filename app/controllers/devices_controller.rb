class DevicesController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @devices = @user.list_devices['device']
  end
end

