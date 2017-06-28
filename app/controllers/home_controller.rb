class HomeController < ApplicationController

  def index
    @stations = Station.all
  end

end
