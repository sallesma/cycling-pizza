class Predictor::HouredAverage < Predictor::Base

  MINUTE_WINDOW = 15

  def predict(station, timestamp)
    timestamp = timestamp.utc

    statuses = station.station_statuses
      .where("EXTRACT(DOW FROM last_update_at) = #{timestamp.wday}")
      .where("ABS(EXTRACT(HOUR FROM (last_update_at::time - '#{timestamp}'::time))*60+EXTRACT(MINUTE FROM (last_update_at::time - '#{timestamp}'::time))) <= #{MINUTE_WINDOW}")

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
