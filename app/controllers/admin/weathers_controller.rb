class Admin::WeathersController < ApplicationController

  def index
    @weathers = Weather.all
  end

end
