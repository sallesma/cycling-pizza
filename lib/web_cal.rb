class WebCal < ExternalApi

  def french_holidays
    params = {
      id: 180,
      format: 'json',
      start_year: 2015,
      end_year: 2022,
      tz:'Europe%2FParis'
    }
    get("http://www.webcal.fi/cal.php", params)
  end
end
