class AddValidAtToPrediction < ActiveRecord::Migration[5.0]
  def change
    add_column :predictions, :valid_at, :timestamp, null: false
  end
end
