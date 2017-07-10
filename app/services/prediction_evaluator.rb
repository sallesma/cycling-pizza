class PredictionEvaluator

  def initialize(prediction)
    @prediction = prediction
  end

  def perform
    return false unless evaluating_status.present?

    @prediction.update(evaluating_status: evaluating_status)
  end

  private

  def evaluating_status
    @evaluating_status ||= StationStatus.matching_prediction(@prediction, 5.minutes).first
  end

end
