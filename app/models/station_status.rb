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

  scope :matching_prediction, -> (prediction, acceptable_offset) {
    where("ABS(EXTRACT( EPOCH FROM last_update_at - '#{prediction.valid_at}')) < #{acceptable_offset}")
    .order("ABS(EXTRACT( EPOCH FROM last_update_at - '#{prediction.valid_at}'))") }

  scope :seven_days_before, -> (other) { where(StationStatus.arel_table[:station_id].eq(other.station_id))
                                      .where(StationStatus.arel_table[:last_update_at].gt(other.last_update_at - 1.week - 5.minutes))
                                      .where(StationStatus.arel_table[:last_update_at].lt(other.last_update_at - 1.week + 5.minutes)) }

  scope :same_day_of_week_and_hour, -> (other) {
    where(StationStatus.arel_table[:station_id].eq(other.station_id))
    .where("EXTRACT(DOW FROM last_update_at) = #{other.last_update_at.wday}")
    .where("ABS(EXTRACT(HOUR FROM (last_update_at::time - '#{other.last_update_at}'::time))*60+EXTRACT(MINUTE FROM (last_update_at::time - '#{other.last_update_at}'::time))) <= #{10.minutes}")
    .where(StationStatus.arel_table[:last_update_at].lt(other.last_update_at - 10.minutes))
  }

end
