class PredictorsManager

  def make_prediction(station, timestamp, predictor = nil)
    predictor ||= choose_predictor

    prediction = predictor.new.predict(station, timestamp)
    prediction.save
    prediction
  end

  private

  def choose_predictor
    Predictor::Dummy
  end
end
