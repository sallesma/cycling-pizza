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

  def result
    result_status.available_bikes
  end

  private

  def result_status
    @result_status ||= @station.station_statuses.order(:last_update_at).last
  end

  def closest_weather
    @closest_weather ||= Weather.last
  end

  class MissingDataError < StandardError ; end

end
