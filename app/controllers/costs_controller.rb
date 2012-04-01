class CostsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @consumption = @user.latest_consumption
    @costs = @consumption['componentList']['component']
    @total_kwh = @consumption['consumption'].to_i
    @total_cost = @consumption['cost']
    @lbs_co2 = (@total_kwh.to_f * 1.293).to_i
  end

end

