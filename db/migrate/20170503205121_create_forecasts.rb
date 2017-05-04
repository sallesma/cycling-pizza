class CreateForecasts < ActiveRecord::Migration[5.0]
  def change
    create_table :forecasts do |t|
      t.string :provider_name
      t.integer :provider_city_id
      t.decimal :latitude
      t.decimal :longitude
      t.datetime :effective_at
      t.string :main
      t.string :secondary
      t.decimal :temperature
      t.decimal :humidity
      t.decimal :clouds
      t.decimal :wind

      t.timestamps
    end

    add_reference :predictions, :forecast
  end
end
