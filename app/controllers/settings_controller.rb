class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user])
    flash[:notice] = "Settings successfully updated."
    redirect_to introductions_path
  end

end

