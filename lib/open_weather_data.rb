class OpenWeatherData < ExternalApi

  def current_paris_weather
    current_weather('Paris, France')
  end

  private

  def current_weather(city)
    fetch('weather', city)
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
