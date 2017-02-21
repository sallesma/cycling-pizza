require 'rails_helper'

describe Predictor::HouredAverage do
  let(:predictor) { Predictor::HouredAverage.new }

  describe 'predict' do
    context 'when there is historic data' do
      it 'returns a new prediction based on same day of week and within 15 minutes data' do
        station = FactoryGirl.create(:station_with_statuses, statuses_count: 5)
        station.station_statuses.first.update(
          available_bikes: 5,
          available_stands: 10,
          last_update_at: Time.new(2017, 1, 10, 12, 50)
        )
        station.station_statuses.second.update(
          available_bikes: 10,
          available_stands: 2,
          last_update_at: Time.new(2017, 1, 10, 12, 40)
        )
        station.station_statuses.third.update(
          available_bikes: 50,
          available_stands: 100,
          last_update_at: Time.new(2017, 1, 10, 11, 50)
        )
        station.station_statuses.fourth.update(
          available_bikes: 50,
          available_stands: 100,
          last_update_at: Time.new(2017, 1, 10, 12, 30)
        )
        station.station_statuses.fifth.update(
          available_bikes: 50,
          available_stands: 100,
          last_update_at: Time.new(2017, 1, 9, 12, 50)
        )

        timestamp = Time.new(2017, 1, 17, 12, 50)
        prediction = predictor.predict(station, timestamp)

        expect(prediction).to be_a_new(Prediction)
        expect(prediction.station).to eq(station)
        expect(prediction.valid_at).to eq(timestamp)
        expect(prediction.available_bikes).to eq(7.5)
        expect(prediction.available_stands).to eq(6)
      end

      it 'returns a wrong result when close to day switch' do
        station = FactoryGirl.create(:station_with_statuses, statuses_count: 2)
        station.station_statuses.first.update(
          available_bikes: 5,
          available_stands: 10,
          last_update_at: Time.new(2017, 1, 10, 23, 50)
        )
        station.station_statuses.second.update(
          available_bikes: 10,
          available_stands: 2,
          last_update_at: Time.new(2017, 1, 11, 0, 5)
        )

        prediction = predictor.predict(station, Time.new(2017, 1, 17, 23, 55))

        expect(prediction.available_bikes).to eq(5)
        expect(prediction.available_stands).to eq(10)
      end
    end

    context 'when there is no relevant data' do
      it 'returns nil' do
        station = FactoryGirl.create(:station)

        prediction = predictor.predict(station, Time.now)

        expect(prediction).to be_nil
      end
    end
  end
end
