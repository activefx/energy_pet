class NeighborsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @neighbor = @user.neighbors_last_month['costAndConsumption']
    @neighbors = @neighbor['component']
    @me = @user.daily_consumption['componentList']['component'][0..(@neighbors.count - 1)]
  end

end

