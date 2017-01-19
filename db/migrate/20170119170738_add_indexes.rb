class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :stations, [:contract_name, :number]
  end
end
