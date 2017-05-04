class OpenWeatherData < ExternalApi

  class InvalidTimeError < StandardError ; end

  def current_paris_weather
    current_weather('Paris, France')
  end

  def paris_forecast(timestamp)
    forecast('Paris, France', timestamp)
  end

  private

  def current_weather(city)
    fetch('weather', city)
  end

  def forecast(city, timestamp)
    raise InvalidTimeError if timestamp.nil? || timestamp < Time.now || timestamp > Time.now + 5.days

    fetch('forecast', city)
  end

  def fetch(endpoint, city)
    params = {
      apiKey: ENV['OPEN_WEATHER_DATA_API_KEY'],
      q: city,
      units: 'metric'
    }
    get("http://api.openweathermap.org/data/2.5/#{endpoint}", params)
  end
end
