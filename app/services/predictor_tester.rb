class PredictorTester

  def test_predictor(predictor, iterations = 100)
    stations = stations_cohort(iterations)

    deviations = stations.map { |station| prediction_deviation(station, predictor) }
    deviations.reduce(:+) / deviations.size
  end

  private

  def prediction_deviation(station, predictor)
    last_status = station.station_statuses.order(:last_update_at).last
    prediction = predictor.predict(station, last_status.last_update_at)
    (prediction.available_bikes - last_status.available_bikes).to_f.abs / last_status.stands
  end

  def stations_cohort(iterations)
    Station.order('RANDOM()').first(iterations)
  end
end
