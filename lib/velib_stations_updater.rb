class VelibStationsUpdater

  def perform
    stations_json = JCDecaux.fetch_velib_stations

    stations_json.each do |station_json|
      station = Station.find_or_create_by(contract_name: station_json['contract_name'], number: station_json['number'])
      station.update(
        name: station_json['name'],
        address: station_json['address'],
        latitude: station_json['position']['latitude'],
        longitude: station_json['position']['longitude'],
        banking: station_json['banking'],
        bonus: station_json['bonus']
      )

      station.station_statuses.create(
        status: station_json['status'],
        stands: station_json['bike_stands'],
        available_bikes: station_json['available_bikes'],
        available_stands: station_json['available_bike_stands'],
        last_update_at: station_json['last_update']
      )
    end
  end
end