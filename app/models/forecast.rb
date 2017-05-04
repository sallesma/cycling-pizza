# == Schema Information
#
# Table name: forecasts
#
#  id               :integer          not null, primary key
#  provider_name    :string
#  provider_city_id :integer
#  latitude         :decimal(, )
#  longitude        :decimal(, )
#  effective_at     :datetime
#  main             :string
#  secondary        :string
#  temperature      :decimal(, )
#  humidity         :decimal(, )
#  clouds           :decimal(, )
#  wind             :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Forecast < ApplicationRecord
  has_many :predictions
end
