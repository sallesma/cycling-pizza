class Predictor::Dummy < Predictor::Base

  def predict(station, timestamp)
    station.predictions.build(
      station: station,
      valid_at: timestamp,
      available_bikes: 0,
      available_stands: 0
    )
  end

end
