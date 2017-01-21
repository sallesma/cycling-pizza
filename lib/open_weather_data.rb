class OpenWeatherData

  def current_paris_weather
    current_weather('Paris, France')
  end

  private

  def current_weather(city)
    response = get(city)

    if (response.code == '200')
      JSON.parse(response.body)
    else
      raise ApiError.new(response.code, response.message, response.body)
    end
  end

  def get(city)
    uri = URI.parse('http://api.openweathermap.org/data/2.5/weather')
    params = {
      APPID: ENV['OPEN_WEATHER_DATA_API_KEY'],
      q: city,
      units: 'metric'
    }
    uri.query = URI.encode_www_form(params)

    Net::HTTP.get_response(uri)
  end

  class ApiError < StandardError
    def initialize(code, message, body)
      @code = code
      @message = message
      @body = body
    end

    def to_s
      "#{@code} (#{@message}): \n#{@body}"
    end
  end
end
