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

FactoryGirl.define do
  factory :weather do
    provider_name 'openweatherdata'
    provider_city_id 2988507
    latitude 48.88
    longitude 2.35
    main 'Clear'
    secondary 'clear sky'
    wind 7.2
    clouds 0.0
    temperature 10.33
    humidity 37
    sunset Time.now
    sunrise Time.now
  end
end
