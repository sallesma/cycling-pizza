class Velib

  def fetch_stations
    uri = URI.parse('https://api.jcdecaux.com/vls/v1/stations')
    params = {
      api_key: ENV['JCDECAUX_API_KEY'],
      contract: 'Paris'
    }
    uri.query = URI.encode_www_form(params)

    JSON.parse(Net::HTTP.get(uri))
  end
end
