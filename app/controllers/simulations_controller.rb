class SimulationsController < ApplicationController

  before_filter :authenticate_user!

  def index
    if params[:day].nil? || params[:day].to_i > 31
      params[:day] = 31
    end
    @simulation = Simulation.where(:day => params[:day]).first
    @user = current_user
    if @simulation.neighbor_percentage > 1.1
      if Rails.env.to_s == "production"
        SuggestionMailer.suggestion_email(@user).deliver
      end
    end
  end

end

