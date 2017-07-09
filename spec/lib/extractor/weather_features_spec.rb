require 'rails_helper'

describe Extractor::WeatherFeatures do
  let(:station_status) { FactoryGirl.create(:station_with_statuses).station_statuses.last }
  let(:weather_features) { Extractor::WeatherFeatures.new(station_status) }

  describe 'compute' do

    context 'when there is a correct matching weather record' do
      it 'returns an array of features' do
        weather = FactoryGirl.create(:weather)
        allow(weather_features).to receive(:closest_weather).and_return(weather)

        result = weather_features.send(:compute)

        expect(result).to be_an_instance_of(Array)
      end
    end

    context 'when there is no matching weather record' do
      it 'raises a missing data error' do
        allow(weather_features).to receive(:closest_weather).and_return(nil)
        expect { weather_features.send(:compute) }.to raise_error(Extractor::StationFeatures::MissingDataError)
      end
    end
  end

  describe 'private methods' do

    describe 'closest_weather' do
      context 'when there are records' do
        it 'returns the more relevant record' do
          weather1 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 8.minutes)
          weather2 = FactoryGirl.create(:weather, created_at: station_status.last_update_at + 2.minutes)
          weather3 = FactoryGirl.create(:weather, created_at: station_status.last_update_at + 12.minutes)

          result = weather_features.send(:closest_weather)

          expect(result).to eq(weather2)
        end
      end
    end

    describe 'one_hour_before_closest_weather' do
      context 'when there are records' do
        it 'returns the more relevant record' do
          weather1 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 68.minutes)
          weather2 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 58.minutes)
          weather3 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 48.minutes)

          result = weather_features.send(:one_hour_before_closest_weather)

          expect(result).to eq(weather2)
        end
      end
    end

    describe 'five_hours_before_closest_weather' do
      context 'when there are records' do
        it 'returns the more relevant record' do
          weather1 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 308.minutes)
          weather2 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 298.minutes)
          weather3 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 288.minutes)

          result = weather_features.send(:five_hours_before_closest_weather)

          expect(result).to eq(weather2)
        end
      end
    end

    describe 'one_day_before_closest_weather' do
      context 'when there are records' do
        it 'returns the more relevant record' do
          weather1 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 1448.minutes)
          weather2 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 1438.minutes)
          weather3 = FactoryGirl.create(:weather, created_at: station_status.last_update_at - 1428.minutes)

          result = weather_features.send(:one_day_before_closest_weather)

          expect(result).to eq(weather2)
        end
      end
    end

    describe 'wind' do
      it 'returns the wind of the closest weather record' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:wind, weather)).to eq(weather.wind)
      end
    end

    describe 'temperature' do
      it 'returns the temperature of the closest weather record' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:temperature, weather)).to eq(weather.temperature)
      end
    end

    describe 'humidity' do
      it 'returns the humidity of the closest weather record' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:humidity, weather)).to eq(weather.humidity)
      end
    end

    describe 'clouds' do
      it 'returns the clouds of the closest weather record' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:clouds, weather)).to eq(weather.clouds)
      end
    end

    describe 'sunny?' do
      it 'returns whether the closest weather record is sunny (1) or not (0)' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:sunny?, weather)).to eq(1)
      end
    end

    describe 'cloudy?' do
      it 'returns whether the closest weather record is cloudy (1) or not (0)' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:cloudy?, weather)).to eq(0)
      end
    end

    describe 'rainy?' do
      it 'returns whether the closest weather record is rainy (1) or not (0)' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:rainy?, weather)).to eq(0)
      end
    end

    describe 'drizzly?' do
      it 'returns whether the closest weather record is drizzly (1) or not (0)' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:drizzly?, weather)).to eq(0)
      end
    end

    describe 'stormy?' do
      it 'returns whether the closest weather record is stormy (1) or not (0)' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:stormy?, weather)).to eq(0)
      end
    end

    describe 'snowy?' do
      it 'returns whether the closest weather record is snowy (1) or not (0)' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:snowy?, weather)).to eq(0)
      end
    end

    describe 'foggy?' do
      it 'returns whether the closest weather record is foggy (1) or not (0)' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:foggy?, weather)).to eq(0)
      end
    end

    describe 'hazy?' do
      it 'returns whether the closest weather record is hazy (1) or not (0)' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:hazy?, weather)).to eq(0)
      end
    end

    describe 'misty?' do
      it 'returns whether the closest weather record is misty (1) or not (0)' do
        weather = FactoryGirl.create(:weather)
        expect(weather_features.send(:misty?, weather)).to eq(0)
      end
    end

  end

end
