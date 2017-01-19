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

class Station < ApplicationRecord
  has_many :station_statuses
end