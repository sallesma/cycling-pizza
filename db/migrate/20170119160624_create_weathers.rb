class CreateWeathers < ActiveRecord::Migration[5.0]
  def change
    create_table :weathers do |t|
      t.string    :provider_name
      t.integer   :provider_city_id
      t.decimal   :latitude
      t.decimal   :longitude
      t.string    :main
      t.string    :secondary
      t.decimal   :wind
      t.decimal   :clouds
      t.decimal   :temperature
      t.decimal   :humidity
      t.timestamp :sunset
      t.timestamp :sunrise

      t.timestamps
    end
  end
end
