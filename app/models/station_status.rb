# == Schema Information
#
# Table name: station_statuses
#
#  id               :integer          not null, primary key
#  station_id       :integer
#  status           :string
#  stands           :integer
#  available_bikes  :integer
#  available_stands :integer
#  last_update_at   :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_station_statuses_on_station_id  (station_id)
#
# Foreign Keys
#
#  fk_rails_b7bb8cb611  (station_id => stations.id)
#

class StationStatus < ApplicationRecord
  belongs_to :station

  scope :last_24h, -> { where(StationStatus.arel_table[:last_update_at].gt(Time.now - 1.day)) }
  scope :fresh, -> { order(last_update_at: :desc) }
end
