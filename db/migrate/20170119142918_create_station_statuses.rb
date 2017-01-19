class CreateStationStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :station_statuses do |t|
      t.references  :station, foreign_key: true
      t.string      :status
      t.integer     :stands
      t.integer     :available_bikes
      t.integer     :available_stands
      t.timestamp   :last_update_at

      t.timestamps
    end
  end
end
