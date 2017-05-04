class ForecastFetcher

  def perform(timestamp)
    begin
      forecast_json = OpenWeatherData.new.paris_forecast(timestamp)
    rescue OpenWeatherData::InvalidTimeError
      return nil
    end

    most_precise = forecast_json['list'].min_by { |forecast| (Time.at(forecast['dt']) - timestamp).abs }

    Forecast.create(
      provider_name: 'openweatherdata',
      provider_city_id: forecast_json['city']['id'],
      latitude: forecast_json['city']['coord']['lat'],
      longitude: forecast_json['city']['coord']['lon'],
      effective_at: timestamp,
      main: most_precise['weather'][0]['main'],
      secondary: most_precise['weather'][0]['description'],
      wind: most_precise['wind']['speed'],
      clouds: most_precise['clouds']['all'],
      temperature: most_precise['main']['temp'],
      humidity: most_precise['main']['humidity']
    )
  end
end
