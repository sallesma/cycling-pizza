class ExternalApi

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

  private

  def get(url, params)
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)

    if (response.code == '200')
      JSON.parse(response.body)
    else
      raise ApiError.new(response.code, response.message, response.body)
    end
  end

end
