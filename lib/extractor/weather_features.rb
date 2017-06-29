class Extractor::WeatherFeatures

  def initialize(station_status)
    @station_status = station_status
  end

  def compute
    raise Extractor::StationFeatures::MissingDataError unless closest_weather.present?

    data
  end

  private

  def data
    [
      wind,
      temperature,
      humidity,
      clouds,
      sunny?,
      cloudy?,
      rainy?,
      drizzly?,
      stormy?,
      snowy?,
      foggy?,
      hazy?,
      misty?
    ]
  end

  def wind
    closest_weather.wind.to_d
  end

  def temperature
    closest_weather.temperature.to_d
  end

  def humidity
    closest_weather.humidity
  end

  def clouds
    closest_weather.clouds
  end

  def sunny?
    closest_weather.main == 'Clear' ? 1 : 0
  end

  def cloudy?
    closest_weather.main == 'Clouds' ? 1 : 0
  end

  def rainy?
    closest_weather.main == 'Rain' ? 1 : 0
  end

  def drizzly?
    closest_weather.main == 'Drizzle' ? 1 : 0
  end

  def stormy?
    closest_weather.main == 'Thunderstorm' ? 1 : 0
  end

  def snowy?
    closest_weather.main == 'Snow' ? 1 : 0
  end

  def foggy?
    closest_weather.main == 'Fog' ? 1 : 0
  end

  def hazy?
    closest_weather.main == 'Haze' ? 1 : 0
  end

  def misty?
    closest_weather.main == 'Mist' ? 1 : 0
  end

  def closest_weather
    @closest_weather ||= Weather.closest(@station_status).first
  end

end
