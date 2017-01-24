class StationsController < ApplicationController

  def index
    contract_name = params[:contract_name] || 'Paris'
    @stations = Station.where(contract_name: contract_name)
  end

end
