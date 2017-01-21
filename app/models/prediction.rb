# == Schema Information
#
# Table name: predictions
#
#  id               :integer          not null, primary key
#  station_id       :integer
#  available_bikes  :decimal(, )
#  available_stands :decimal(, )
#  predictor        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_predictions_on_station_id  (station_id)
#
# Foreign Keys
#
#  fk_rails_c6f8ad43fc  (station_id => stations.id)
#

class Prediction < ApplicationRecord
  belongs_to :station
end
