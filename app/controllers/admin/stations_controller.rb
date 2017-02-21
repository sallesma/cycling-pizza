class Admin::StationsController < ApplicationController

  def index
    contract_name = params[:contract_name] || 'Paris'
    @stations = Station.where(contract_name: contract_name)
    @station_statuses_counts = StationStatus.group(:station_id).count
  end

end
