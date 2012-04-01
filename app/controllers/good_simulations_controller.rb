class GoodSimulationsController < ApplicationController

  def index

  end

  def show
    @simulation = Simulation.get_sim(params[:last_sim] || 0)
  end

end

