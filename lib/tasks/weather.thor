require 'thor/rails'

class Weather < Thor
  include Thor::Rails

  desc "fetch", "Fetch weather from OpenWeatherData"
  def fetch
    puts 'Starting to fetch...'

    WeatherFetcher.new.perform

    puts 'Finished to fetch.'
  end

end