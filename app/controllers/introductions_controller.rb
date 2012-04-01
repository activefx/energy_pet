class IntroductionsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    if @user.phone_number.blank?
      redirect_to settings_path and return
    end
    @simulation = Simulation.where(:day => 1).first
  end

end

