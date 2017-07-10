class AddEvaluatingStatusToPredictions < ActiveRecord::Migration[5.0]
  def change
    add_reference :predictions, :evaluating_status, index: true
  end
end
