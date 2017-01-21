class CreatePredictions < ActiveRecord::Migration[5.0]
  def change
    create_table :predictions do |t|
      t.references :station, foreign_key: true
      t.decimal :available_bikes
      t.decimal :available_stands
      t.string  :predictor

      t.timestamps
    end
  end
end
