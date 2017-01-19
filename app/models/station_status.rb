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

class StationStatus < ApplicationRecord
  belongs_to :station
end
