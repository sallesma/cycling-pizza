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

class Prediction < ApplicationRecord
  belongs_to :station
  belongs_to :forecast, optional: true
  belongs_to :evaluating_status, optional: true, class_name: StationStatus

  scope :recent, -> { order(created_at: :desc) }

  def evaluated?
    self.evaluating_status.present?
  end

  def evaluable?
    !self.evaluated? && self.valid_at < Time.now
  end

  def bikes_deviation
    self.available_bikes - self.evaluating_status.available_bikes if self.evaluated?
  end

  def stands_deviation
    self.available_stands - self.evaluating_status.available_stands if self.evaluated?
  end
end
