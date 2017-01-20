class JCDecauxApi

  def fetch_velib_stations
    fetch_stations('Paris')
  end

  def fetch_velib_station(station_id)
    fetch_station('Paris', station_id)
  end

  private

  def fetch_stations(contract)
    fetch('https://api.jcdecaux.com/vls/v1/stations', { contract: 'Paris'})
  end

  def fetch_station(contract, station_id)
    fetch("https://api.jcdecaux.com/vls/v1/stations/#{station_id}", { contract: 'Paris'})
  end

  def fetch(url, params)
    uri = URI.parse(url)
    params = {
      apiKey: ENV['JCDECAUX_API_KEY']
    }.merge(params)

    uri.query = URI.encode_www_form(params)

    JSON.parse(Net::HTTP.get(uri))
  end
end
