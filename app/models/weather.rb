# == Schema Information
#
# Table name: weathers
#
#  id               :integer          not null, primary key
#  provider_name    :string
#  provider_city_id :integer
#  latitude         :decimal(, )
#  longitude        :decimal(, )
#  main             :string
#  secondary        :string
#  wind             :decimal(, )
#  clouds           :decimal(, )
#  temperature      :decimal(, )
#  humidity         :decimal(, )
#  sunset           :datetime
#  sunrise          :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Weather < ApplicationRecord
end
