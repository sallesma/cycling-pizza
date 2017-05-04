require 'rails_helper'

describe ForecastFetcher do
  let(:forecast_fetcher) { ForecastFetcher.new }

  context 'when the API raises a InvalidTimeError' do
    it 'returns nil' do
      allow_any_instance_of(OpenWeatherData).to receive(:paris_forecast).and_raise(OpenWeatherData::InvalidTimeError)

      forecast = forecast_fetcher.perform(Time.now - 1.hour)

      expect(forecast).to be_nil
    end
  end

  context 'when the api returns forecasts as a hash' do
    it 'selects the forecast closest to the requested timestamp' do
      timestamp = Time.now + 1.hour
      allow_any_instance_of(OpenWeatherData).to receive(:paris_forecast).and_return({"cod"=>"200","message"=>0.0034,"cnt"=>40,"list"=>[{"dt"=>timestamp + 1.hour,"main"=>{"temp"=>8.28,"temp_min"=>8.28,"temp_max"=>9.57,"pressure"=>1019.42,"sea_level"=>1031.72,"grnd_level"=>1019.42,"humidity"=>99,"temp_kf"=>-1.3},"weather"=>[{"id"=>500,"main"=>"Rain","description"=>"light rain","icon"=>"10n"}],"clouds"=>{"all"=>80},"wind"=>{"speed"=>1.36,"deg"=>14.0012},"rain"=>{"3h"=>0.53},"sys"=>{"pod"=>"n"},"dt_txt"=>"2017-05-03 21:00:00"}, {"dt"=>timestamp+4.hours, "main"=>{"temp"=>19.68, "temp_min"=>19.68, "temp_max"=>19.68, "pressure"=>1022.54, "sea_level"=>1034.46, "grnd_level"=>1022.54, "humidity"=>67, "temp_kf"=>0}, "weather"=>[{"id"=>802, "main"=>"Clouds", "description"=>"scattered clouds", "icon"=>"03d"}], "clouds"=>{"all"=>32}, "wind"=>{"speed"=>2.58, "deg"=>50.5006}, "rain"=>{}, "sys"=>{"pod"=>"d"}}],"city"=>{"id"=>2988507,"name"=>"Paris","coord"=>{"lat"=>48.8534,"lon"=>2.3488},"country"=>"FR"}})

      previous_count = Forecast.count

      forecast_fetcher.perform(timestamp)

      expect(Forecast.count).to eq(previous_count + 1)

      forecast = Forecast.last
      expect(forecast.provider_name).to eq('openweatherdata')
      expect(forecast.provider_city_id).to eq(2988507)
      expect(forecast.latitude).to eq(48.8534)
      expect(forecast.longitude).to eq(2.3488)
      expect(forecast.effective_at.to_i).to eq(timestamp.to_i)
      expect(forecast.main).to eq('Rain')
      expect(forecast.secondary).to eq('light rain')
      expect(forecast.wind).to eq(1.36)
      expect(forecast.clouds).to eq(80)
      expect(forecast.temperature.to_f).to eq(8.28)
      expect(forecast.humidity).to eq(99)
    end
  end
end
