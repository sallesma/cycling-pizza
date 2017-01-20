class WeatherFetcher

  def perform
    weather_json = OpenWeatherDataApi.new.fetch_current_paris_weather

    weather = Weather.create(
      provider_name: 'openweatherdata',
      provider_city_id: weather_json['id'],
      latitude: weather_json['coord']['lat'],
      longitude: weather_json['coord']['lon'],
      main: weather_json['weather'][0]['main'],
      secondary: weather_json['weather'][0]['description'],
      wind: weather_json['wind']['speed'],
      clouds: weather_json['clouds']['all'],
      temperature: weather_json['main']['temp'],
      humidity: weather_json['main']['humidity'],
      sunset: Time.at(weather_json['sys']['sunset']),
      sunrise: Time.at(weather_json['sys']['sunrise'])
    )
  end
end
