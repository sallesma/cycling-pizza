# == Schema Information
#
# Table name: stations
#
#  id            :integer          not null, primary key
#  number        :string
#  contract_name :string
#  name          :string
#  address       :string
#  latitude      :decimal(, )
#  longitude     :decimal(, )
#  banking       :boolean
#  bonus         :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_stations_on_contract_name_and_number  (contract_name,number)
#

class Station < ApplicationRecord
  has_many :station_statuses
  has_many :predictions

  accepts_nested_attributes_for :station_statuses
end
