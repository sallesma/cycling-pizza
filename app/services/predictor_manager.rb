class PredictorManager

  def make_prediction(station, timestamp, predictor = nil)
    predictor ||= choose_predictor

    prediction = predictor.predict(station, timestamp)
    prediction.save
    prediction
  end

  private

  def choose_predictor
    Predictor::HouredAverage.new
  end
end
