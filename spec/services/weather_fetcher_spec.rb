require 'rails_helper'

describe WeatherFetcher do
  let(:weather_fetcher) { WeatherFetcher.new }

  context 'when the api returns a hash of current weather' do
    it 'creates the associated weather record' do
      allow_any_instance_of(OpenWeatherData).to receive(:current_paris_weather).and_return({"coord"=>{"lon"=>2.35, "lat"=>48.85}, "weather"=>[{"id"=>721, "main"=>"Haze", "description"=>"haze", "icon"=>"50d"}, {"id"=>701, "main"=>"Mist", "description"=>"mist", "icon"=>"50d"}], "base"=>"stations", "main"=>{"temp"=>0.5, "pressure"=>1026, "humidity"=>82, "temp_min"=>-1, "temp_max"=>2}, "visibility"=>8000, "wind"=>{"speed"=>1.5, "deg"=>90}, "clouds"=>{"all"=>0}, "dt"=>1485001800, "sys"=>{"type"=>1, "id"=>5615, "message"=>0.0023, "country"=>"FR", "sunrise"=>1484983980, "sunset"=>1485016302}, "id"=>2988507, "name"=>"Paris", "cod"=>200})

      previous_count = Weather.count
      weather_fetcher.perform

      expect(Weather.count).to eq(previous_count+1)

      weather = Weather.last
      expect(weather.provider_name).to eq('openweatherdata')
      expect(weather.provider_city_id).to eq(2988507)
      expect(weather.latitude).to eq(48.85)
      expect(weather.longitude).to eq(2.35)
      expect(weather.main).to eq('Haze')
      expect(weather.secondary).to eq('haze')
      expect(weather.wind).to eq(1.5)
      expect(weather.clouds).to eq(0)
      expect(weather.temperature).to eq(0.5)
      expect(weather.humidity).to eq(82)
      expect(weather.sunset).to eq(Time.at(1485016302))
      expect(weather.sunrise).to eq(Time.at(1484983980))
    end
  end
end
