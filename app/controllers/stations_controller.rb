class StationsController < ApplicationController

  before_action :set_station, only: :show

  def show
  end

  private

  def set_station
    @station = Station.find(params[:id])
  end

end
