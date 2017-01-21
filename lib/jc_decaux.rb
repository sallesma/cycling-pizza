class JCDecaux < ExternalApi

  def velib_stations
    stations('Paris')
  end

  def velib_station(station_id)
    station('Paris', station_id)
  end

  private

  def stations(contract)
    fetch('stations', { contract: 'Paris'})
  end

  def station(contract, station_id)
    fetch("stations/#{station_id}", { contract: 'Paris'})
  end

  def fetch(endpoint, params = {})
    get("https://api.jcdecaux.com/vls/v1/#{endpoint}", params.merge(apiKey: ENV['JCDECAUX_API_KEY']))
  end
end
