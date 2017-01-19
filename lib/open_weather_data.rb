module OpenWeatherData

  def self.fetch_current_paris_weather
    fetch_current_weather('Paris, France')
  end

  def self.fetch_current_weather(city)
    uri = URI.parse('http://api.openweathermap.org/data/2.5/weather')
    params = {
      APPID: ENV['OPEN_WEATHER_DATA_API_KEY'],
      q: 'Paris',
      units: 'metric'
    }

    uri.query = URI.encode_www_form(params)

    JSON.parse(Net::HTTP.get(uri))
  end
end
