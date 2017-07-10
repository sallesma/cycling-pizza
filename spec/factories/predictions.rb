# == Schema Information
#
# Table name: predictions
#
#  id                   :integer          not null, primary key
#  station_id           :integer
#  available_bikes      :decimal(, )
#  available_stands     :decimal(, )
#  predictor            :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  valid_at             :datetime         not null
#  forecast_id          :integer
#  evaluating_status_id :integer
#
# Indexes
#
#  index_predictions_on_evaluating_status_id  (evaluating_status_id)
#  index_predictions_on_forecast_id           (forecast_id)
#  index_predictions_on_station_id            (station_id)
#
# Foreign Keys
#
#  fk_rails_c6f8ad43fc  (station_id => stations.id)
#

FactoryGirl.define do
  factory :prediction do
    valid_at { Time.now }

    factory :prediction_made do
      available_bikes 5
      available_stands 5
    end
  end
end
