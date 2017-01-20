require 'thor/rails'

class Stations < Thor
  include Thor::Rails

  desc "populate_velib", "Fetch and insert all stations from Velib"
  def populate_velib
    puts 'Starting to populate...'

    VelibStationsUpdater.new.perform

    puts 'Finished to populate'
    puts "#{Station.count} stations in the database"
  end

  desc "fetch_velib", "Fetch given stations from Velib"
  method_option :only, type: :array, default: []
  def fetch_velib
    station_ids = options[:only]

    puts 'Starting to fetch...'
    puts "Stations to fetch: #{station_ids}" if station_ids.any?

    VelibStationsUpdater.new.perform(station_ids)

    puts 'Finished to fetch'
    puts "#{Station.count} stations in the database"
  end

end