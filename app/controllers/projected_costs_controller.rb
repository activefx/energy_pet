class ProjectedCostsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @costs = @user.projected_consumption
  end


end

