require 'rails_helper'

describe Predictor::Dummy do
  let(:predictor) { Predictor::Dummy.new }

  describe 'predict' do
    it 'always returns a Prediction with empty values' do
      station = FactoryGirl.create(:station)
      timestamp = Time.now
      prediction = predictor.predict(station, timestamp)

      expect(prediction).to be_a_new(Prediction)
      expect(prediction.station).to eq(station)
      expect(prediction.valid_at).to eq(timestamp)
      expect(prediction.available_bikes).to eq(0)
      expect(prediction.available_stands).to eq(0)
    end
  end
end
