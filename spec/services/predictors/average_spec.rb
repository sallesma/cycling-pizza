require 'rails_helper'

describe Predictor::Average do
  let(:predictor) { Predictor::Average.new }

  describe 'predict' do
    context 'when there is historic data' do
      it 'always returns a new prediction' do
        station = FactoryGirl.create(:station_with_statuses, statuses_count: 2)
        station.station_statuses.first.update(
          available_bikes: 5,
          available_stands: 10
        )
        station.station_statuses.second.update(
          available_bikes: 10,
          available_stands: 2
        )

        timestamp = Time.now
        prediction = predictor.predict(station, timestamp)

        expect(prediction).to be_a_new(Prediction)
        expect(prediction.station).to eq(station)
        expect(prediction.valid_at).to eq(timestamp)
        expect(prediction.available_bikes).to eq(7.5)
        expect(prediction.available_stands).to eq(6)
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
