require 'rails_helper'

describe Predictor::Average do
  let(:predictor) { Predictor::Average.new }

  describe 'predict' do
    it 'always returns a Prediction with empty values' do
      station = FactoryGirl.create(:station_with_statuses, statuses_count: 2)
      station.station_statuses.first.update(
        available_bikes: 5,
        available_stands: 10
      )
      station.station_statuses.second.update(
        available_bikes: 10,
        available_stands: 2
      )

      prediction = predictor.predict(station, Time.now)

      expect(prediction).to be_a_new(Prediction)
      expect(prediction.station).to eq(station)
      expect(prediction.available_bikes).to eq(7.5)
      expect(prediction.available_stands).to eq(6)
    end
  end
end
