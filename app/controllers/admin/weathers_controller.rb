class Admin::WeathersController < ApplicationController

  def index
    @weathers = Weather.all
    @recent_weathers = Weather.order(created_at: :desc).limit(50)
  end

end
