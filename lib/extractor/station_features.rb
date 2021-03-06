class Extractor::StationFeatures

  NO_RESULT = 0

  def initialize(station)
    @station = station
  end

  def compute
    return OpenStruct.new(success?: false) unless result_status

    begin
      OpenStruct.new(success?: true, data: data)
    rescue MissingDataError
      OpenStruct.new(success?: false)
    end
  end

  private

  def data
    [
      bikes_7_days_before,
      bikes_same_day_of_week_and_hour,
      holiday?,
      *weather_data,
      result
    ]
  end

  def bikes_7_days_before
    status = StationStatus.seven_days_before(result_status).last
    raise MissingDataError unless status.present?

    status.available_bikes
  end

  def bikes_same_day_of_week_and_hour
    statuses = StationStatus.same_day_of_week_and_hour(result_status)
    raise MissingDataError unless statuses.any?

    statuses.pluck(:available_bikes).reduce(:+).to_d / statuses.size
  end

  def holiday?
    Holiday.where(date: result_status.last_update_at.to_date).any? ? 1 : 0
  end

  def weather_data
    Extractor::WeatherFeatures.new(result_status).compute
  end

  def result
    result_status.available_bikes
  end

  private

  def result_status
    @result_status ||= @station.station_statuses.order(:last_update_at).last
  end

  class MissingDataError < StandardError ; end

end
