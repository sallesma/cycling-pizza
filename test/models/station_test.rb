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

require 'test_helper'

class StationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
