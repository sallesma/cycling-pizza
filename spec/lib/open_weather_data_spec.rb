require 'rails_helper'
require 'net/http'

describe OpenWeatherData do

  describe '#current_paris_weather' do
    context 'when returns an error' do
      it 'raises an exception containing the error information' do
        unauthorized = Net::HTTPResponse.new('1.1', '401', 'Unauthorized')
        allow(unauthorized).to receive(:body).and_return("{\"cod\":401, \"message\": \"Invalid API key. Please see http://openweathermap.org/faq#error401 for more info.\"}")

        allow(Net::HTTP).to receive(:get_response).and_return(unauthorized)

        expect { OpenWeatherData.new.current_paris_weather }.to raise_error(OpenWeatherData::ApiError)
      end
    end

    context 'when returns ok' do
      it 'returns the result as json' do
        ok = Net::HTTPResponse.new('1.1', '200', 'OK')
        allow(ok).to receive(:body).and_return("{\"coord\":{\"lon\":2.35,\"lat\":48.85},\"weather\":[{\"id\":721,\"main\":\"Haze\",\"description\":\"haze\",\"icon\":\"50d\"},{\"id\":701,\"main\":\"Mist\",\"description\":\"mist\",\"icon\":\"50d\"}],\"base\":\"stations\",\"main\":{\"temp\":0.5,\"pressure\":1026,\"humidity\":82,\"temp_min\":-1,\"temp_max\":2},\"visibility\":8000,\"wind\":{\"speed\":1.5,\"deg\":90},\"clouds\":{\"all\":0},\"dt\":1485001800,\"sys\":{\"type\":1,\"id\":5615,\"message\":0.0023,\"country\":\"FR\",\"sunrise\":1484983980,\"sunset\":1485016302},\"id\":2988507,\"name\":\"Paris\",\"cod\":200}")

        allow(Net::HTTP).to receive(:get_response).and_return(ok)

        response = OpenWeatherData.new.current_paris_weather
        expect(response).to eq({"coord"=>{"lon"=>2.35, "lat"=>48.85}, "weather"=>[{"id"=>721, "main"=>"Haze", "description"=>"haze", "icon"=>"50d"}, {"id"=>701, "main"=>"Mist", "description"=>"mist", "icon"=>"50d"}], "base"=>"stations", "main"=>{"temp"=>0.5, "pressure"=>1026, "humidity"=>82, "temp_min"=>-1, "temp_max"=>2}, "visibility"=>8000, "wind"=>{"speed"=>1.5, "deg"=>90}, "clouds"=>{"all"=>0}, "dt"=>1485001800, "sys"=>{"type"=>1, "id"=>5615, "message"=>0.0023, "country"=>"FR", "sunrise"=>1484983980, "sunset"=>1485016302}, "id"=>2988507, "name"=>"Paris", "cod"=>200})
      end
    end
  end

  describe '#paris_forecast' do
    context 'when the requested timestamp is nil' do
      it 'raises an exception' do
        expect { OpenWeatherData.new.paris_forecast(nil) }.to raise_error(OpenWeatherData::InvalidTimeError)
      end
    end
    context 'when the requested timestamp is in the past' do
      it 'raises an exception' do
        expect { OpenWeatherData.new.paris_forecast(Time.now - 1.hour) }.to raise_error(OpenWeatherData::InvalidTimeError)
      end
    end
    context 'when the requested timestamp is more than 5 days in the future' do
      it 'raises an exception' do
        expect { OpenWeatherData.new.paris_forecast(Time.now + 6.days) }.to raise_error(OpenWeatherData::InvalidTimeError)
      end
    end

    context 'when returns an error' do
      it 'raises an exception containing the error information' do
        unauthorized = Net::HTTPResponse.new('1.1', '401', 'Unauthorized')
        allow(unauthorized).to receive(:body).and_return("{\"cod\":401, \"message\": \"Invalid API key. Please see http://openweathermap.org/faq#error401 for more info.\"}")

        allow(Net::HTTP).to receive(:get_response).and_return(unauthorized)

        expect { OpenWeatherData.new.current_paris_weather }.to raise_error(OpenWeatherData::ApiError)
      end
    end

    context 'when returns ok' do
      it 'returns the result as json' do
        ok = Net::HTTPResponse.new('1.1', '200', 'OK')
        allow(ok).to receive(:body).and_return("{\"cod\":\"200\",\"message\":0.0034,\"cnt\":40,\"list\":[{\"dt\":1493845200,\"main\":{\"temp\":8.28,\"temp_min\":8.28,\"temp_max\":9.57,\"pressure\":1019.42,\"sea_level\":1031.72,\"grnd_level\":1019.42,\"humidity\":99,\"temp_kf\":-1.3},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10n\"}],\"clouds\":{\"all\":80},\"wind\":{\"speed\":1.36,\"deg\":14.0012},\"rain\":{\"3h\":0.53},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2017-05-03 21:00:00\"}],\"city\":{\"id\":2988507,\"name\":\"Paris\",\"coord\":{\"lat\":48.8534,\"lon\":2.3488},\"country\":\"FR\"}}")

        allow(Net::HTTP).to receive(:get_response).and_return(ok)

        response = OpenWeatherData.new.current_paris_weather
        expect(response).to eq({"cod"=>"200","message"=>0.0034,"cnt"=>40,"list"=>[{"dt"=>1493845200,"main"=>{"temp"=>8.28,"temp_min"=>8.28,"temp_max"=>9.57,"pressure"=>1019.42,"sea_level"=>1031.72,"grnd_level"=>1019.42,"humidity"=>99,"temp_kf"=>-1.3},"weather"=>[{"id"=>500,"main"=>"Rain","description"=>"light rain","icon"=>"10n"}],"clouds"=>{"all"=>80},"wind"=>{"speed"=>1.36,"deg"=>14.0012},"rain"=>{"3h"=>0.53},"sys"=>{"pod"=>"n"},"dt_txt"=>"2017-05-03 21:00:00"}],"city"=>{"id"=>2988507,"name"=>"Paris","coord"=>{"lat"=>48.8534,"lon"=>2.3488},"country"=>"FR"}})
      end
    end
  end

end
