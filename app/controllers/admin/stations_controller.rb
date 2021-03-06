class Admin::StationsController < ApplicationController

  before_action :set_station, only: :show

  def index
    contract_name = params[:contract_name] || 'Paris'
    @stations = Station.where(contract_name: contract_name)
    @station_statuses_counts = StationStatus.group(:station_id).count
  end

  def show
  end

  private

  def set_station
    @station = Station.find(params[:id])
  end
end
