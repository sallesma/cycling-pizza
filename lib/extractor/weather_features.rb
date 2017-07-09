class Extractor::WeatherFeatures

  def initialize(station_status)
    @station_status = station_status
  end

  def compute
    unless closest_weather.present? &&
        one_hour_before_closest_weather.present? &&
        five_hours_before_closest_weather.present? &&
        one_day_before_closest_weather.present?
      raise Extractor::StationFeatures::MissingDataError
    end

    data(closest_weather)
      .concat(data(one_hour_before_closest_weather))
      .concat(data(five_hours_before_closest_weather))
      .concat(data(one_day_before_closest_weather))
  end

  private

  def data(weather_record)
    [
      wind(weather_record),
      temperature(weather_record),
      humidity(weather_record),
      clouds(weather_record),
      sunny?(weather_record),
      cloudy?(weather_record),
      rainy?(weather_record),
      drizzly?(weather_record),
      stormy?(weather_record),
      snowy?(weather_record),
      foggy?(weather_record),
      hazy?(weather_record),
      misty?(weather_record)
    ]
  end

  def wind(weather_record)
    weather_record.wind.to_d
  end

  def temperature(weather_record)
    weather_record.temperature.to_d
  end

  def humidity(weather_record)
    weather_record.humidity
  end

  def clouds(weather_record)
    weather_record.clouds
  end

  def sunny?(weather_record)
    weather_record.main == 'Clear' ? 1 : 0
  end

  def cloudy?(weather_record)
    weather_record.main == 'Clouds' ? 1 : 0
  end

  def rainy?(weather_record)
    weather_record.main == 'Rain' ? 1 : 0
  end

  def drizzly?(weather_record)
    weather_record.main == 'Drizzle' ? 1 : 0
  end

  def stormy?(weather_record)
    weather_record.main == 'Thunderstorm' ? 1 : 0
  end

  def snowy?(weather_record)
    weather_record.main == 'Snow' ? 1 : 0
  end

  def foggy?(weather_record)
    weather_record.main == 'Fog' ? 1 : 0
  end

  def hazy?(weather_record)
    weather_record.main == 'Haze' ? 1 : 0
  end

  def misty?(weather_record)
    weather_record.main == 'Mist' ? 1 : 0
  end

  def closest_weather
    @closest_weather ||= Weather.closest(@station_status).first
  end

  def one_hour_before_closest_weather
    @one_hour_before_closest_weather ||= Weather.closest(@station_status, -1.hour).first
  end

  def five_hours_before_closest_weather
    @five_hours_before_closest_weather ||= Weather.closest(@station_status, -5.hours).first
  end

  def one_day_before_closest_weather
    @one_day_before_closest_weather ||= Weather.closest(@station_status, -1.day).first
  end
end
