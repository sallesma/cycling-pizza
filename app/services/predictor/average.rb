class Predictor::Average < Predictor::Base

  def predict(station, timestamp)
    available_bikes = station.station_statuses.pluck(:available_bikes).reduce(:+).to_d / station.station_statuses.size
    available_stands = station.station_statuses.pluck(:available_stands).reduce(:+).to_d / station.station_statuses.size

    station.predictions.build(
      station: station,
      available_bikes: available_bikes,
      available_stands: available_stands
    )
  end

end
