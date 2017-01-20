class JCDecauxApi

  def fetch_velib_stations
    fetch_stations('Paris')
  end

  private

  def fetch_stations(contract)
    uri = URI.parse('https://api.jcdecaux.com/vls/v1/stations')
    params = {
      apiKey: ENV['JCDECAUX_API_KEY'],
      contract: 'Paris'
    }

    uri.query = URI.encode_www_form(params)

    JSON.parse(Net::HTTP.get(uri))
  end
end
