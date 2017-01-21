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

FactoryGirl.define do
  factory :station do
    number '10002'
    contract_name 'Paris'
    name '10002 - STRASBOURG'
    latitude 48.8696791244594
    longitude 2.9
    banking true
    bonus false
  end
end
