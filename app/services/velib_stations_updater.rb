class VelibStationsUpdater

  def perform(stations_ids = [])
    stations_json = fetch_data(stations_ids)

    stations_json.each do |station_json|
      upsert_station(station_json)
    end
  end

  private

  def fetch_data(stations_ids)
    if stations_ids.empty?
      api.fetch_velib_stations
    else
      stations_ids.map {|id| api.fetch_velib_station(id)}
    end
  end

  def upsert_station(station_json)
      station = Station.find_or_create_by(contract_name: station_json['contract_name'], number: station_json['number'])
      station.update(
        name: station_json['name'],
        address: station_json['address'],
        latitude: station_json['position']['lat'],
        longitude: station_json['position']['lon'],
        banking: station_json['banking'],
        bonus: station_json['bonus']
      )

      station.station_statuses.create(
        status: station_json['status'],
        stands: station_json['bike_stands'],
        available_bikes: station_json['available_bikes'],
        available_stands: station_json['available_bike_stands'],
        last_update_at: Time.at(station_json['last_update'] / 1000)
      )
  end

  def api
    @jc_decaux_api ||= JCDecauxApi.new
  end
end