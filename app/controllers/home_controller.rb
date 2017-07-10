class HomeController < ApplicationController

  def index
    @stations = Station.all
    @predictions = Prediction.recent.limit(5)
  end

end
