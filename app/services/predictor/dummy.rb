class Predictor::Dummy < Predictor::Base

  def predict(station, timestamp)
    station.predictions.build(
      station: station,
      available_bikes: 0,
      available_stands: 0
    )
  end

end
