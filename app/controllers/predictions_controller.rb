class PredictionsController < ApplicationController

  before_action :set_prediction, only: :show

  def new
    @prediction = Prediction.new
  end

  def create
    station = Station.find(params[:prediction][:station_id])
    timestamp = Time.parse(params[:prediction][:valid_at])


    @prediction = PredictorManager.new.make_prediction(station, timestamp)
    redirect_to @prediction
  end

  def show
  end

  private

  def set_prediction
    @prediction = Prediction.find(params[:id])
  end

end
