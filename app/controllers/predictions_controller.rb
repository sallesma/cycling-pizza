class PredictionsController < ApplicationController

  before_action :set_prediction, only: [:show, :evaluate]

  def new
    @prediction = Prediction.new
  end

  def create
    station = Station.find(params[:prediction][:station_id])
    timestamp = Time.parse(params[:prediction][:valid_at])


    @prediction = PredictorManager.new.make_prediction(station, timestamp)

    if @prediction.persisted?
      redirect_to @prediction
    else
      render :new
    end
  end

  def index
    @predictions = Prediction.all
  end

  def show
  end

  def evaluate
    PredictionEvaluator.new(@prediction).perform
    redirect_to @prediction
  end

  private

  def set_prediction
    @prediction = Prediction.find(params[:id])
  end

end
