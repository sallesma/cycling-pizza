class Predictor::Average < Predictor::Base

  def predict(station, timestamp)
    statuses = station.station_statuses

    return nil unless statuses.any?

    available_bikes = statuses.pluck(:available_bikes).reduce(:+).to_d / statuses.size
    available_stands = statuses.pluck(:available_stands).reduce(:+).to_d / statuses.size

    station.predictions.build(
      station: station,
      valid_at: timestamp,
      available_bikes: available_bikes,
      available_stands: available_stands
    )
  end

end
