require 'rails_helper'

describe Extractor::StationFeatures do

  describe '#compute' do
    context 'when there are station statuses' do
      it 'returns a successfull struct with data' do
        station = FactoryGirl.create(:station_with_statuses)
        station_features = Extractor::StationFeatures.new(station)
        allow(station_features).to receive(:data).and_return([0,1,2,3,4,5,6,7,8,9])

        output = station_features.compute

        expect(output.success?).to be_truthy
        expect(output.data).to eq([0,1,2,3,4,5,6,7,8,9])
      end
    end

    context 'when there are no station statuses' do
      it 'returns an unsuccessfull struct' do
        station = FactoryGirl.create(:station)
        station_features = Extractor::StationFeatures.new(station)

        output = station_features.compute

        expect(output.success?).to be_falsy
      end
    end

    context 'when one data is missing' do
      it 'returns an unsuccessfull struct' do
        station = FactoryGirl.create(:station_with_statuses)
        station_features = Extractor::StationFeatures.new(station)
        allow(station_features).to receive(:bikes_7_days_before).and_raise(Extractor::StationFeatures::MissingDataError)

        output = station_features.compute

        expect(output.success?).to be_falsy
      end
    end
  end

  describe 'private methods' do
    let(:station) { FactoryGirl.create(:station_with_statuses) }
    let(:station_features) { Extractor::StationFeatures.new(station) }

    describe '#bikes_7_days_before' do
      context 'if there is a status for 7 days ago' do
        it 'returns the available bikes 1 week before' do
          FactoryGirl.create(:station_status, station: station, last_update_at: station.station_statuses.last.last_update_at - 1.week, available_bikes: 2)

          value = station_features.send(:bikes_7_days_before)

          expect(value).to eq(2)
        end
      end

      context 'if there is no corresponding status' do
        it 'raises a missing data error' do
          expect { station_features.send(:bikes_7_days_before) }.to raise_error(Extractor::StationFeatures::MissingDataError)
        end
      end
    end

    describe '#bikes_same_day_of_week_and_hour' do
      context 'if there are corresponding values' do
        it 'returns the average available bikes at the same hour and same day of week' do
          FactoryGirl.create(:station_status, station: station, last_update_at: station.station_statuses.last.last_update_at - 1.week, available_bikes: 2)
          FactoryGirl.create(:station_status, station: station, last_update_at: station.station_statuses.last.last_update_at - 1.week, available_bikes: 4)

          value = station_features.send(:bikes_same_day_of_week_and_hour)

          expect(value).to eq(3)
        end
      end

      context 'if there is no corresponding status' do
        it 'raises a missing data error' do
          expect { station_features.send(:bikes_same_day_of_week_and_hour) }.to raise_error(Extractor::StationFeatures::MissingDataError)
        end
      end
    end

    describe '#result' do
      it 'returns the last status available bikes' do
        result = station_features.send(:result)

        expect(result).to eq(station.station_statuses.order(:last_update_at).last.available_bikes)
      end
    end
  end
end
