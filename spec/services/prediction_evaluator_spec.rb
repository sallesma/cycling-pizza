require 'rails_helper'

describe PredictionEvaluator do

  context 'when there is a matching status' do
    let(:station) { FactoryGirl.create(:station_with_statuses, statuses_count: 3) }
    let(:prediction) { FactoryGirl.create(:prediction_made, station: station) }
    let(:prediction_evaluator) { PredictionEvaluator.new(prediction) }
    it 'assigns it to the prediction and returns true' do
      station.station_statuses.first.update(last_update_at: prediction.valid_at - 6.minutes)
      station.station_statuses.second.update(last_update_at: prediction.valid_at + 4.minutes)
      station.station_statuses.third.update(last_update_at: prediction.valid_at + 14.minutes)

      result = prediction_evaluator.perform

      expect(result).to be_truthy
      expect(prediction.evaluating_status).to eq(station.station_statuses.second)
    end
  end

  context 'when there is no matching status' do
    let(:station) { FactoryGirl.create(:station) }
    let(:prediction) { FactoryGirl.create(:prediction_made, station: station) }
    let(:prediction_evaluator) { PredictionEvaluator.new(prediction) }
    it 'does nothing and returns false' do
      result = prediction_evaluator.perform

      expect(result).to be_falsy
      expect(prediction.evaluating_status).to be_nil
    end
  end
end
