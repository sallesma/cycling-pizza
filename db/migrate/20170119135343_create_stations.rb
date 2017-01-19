class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.string  :number
      t.string  :contract_name
      t.string  :name
      t.string  :address
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :banking
      t.boolean :bonus

      t.timestamps
    end
  end
end
