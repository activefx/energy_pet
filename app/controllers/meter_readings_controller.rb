class MeterReadingsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @readings = @user.latest_meter_readings['MeterReading'].first['Readings'].reverse
    #@kwh = @readings.collect{ |x| x['value'] }.sum.to_i / 4000
  end

end

