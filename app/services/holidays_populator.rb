class HolidaysPopulator

  def perform
    holidays_json = api.french_holidays

    holidays_json.each do |holiday_json|
      Holiday.create(
        country: 'FR',
        name: holiday_json['name'],
        date: holiday_json['date']
      )
    end
  end

  private

  def api
    @api ||= WebCal.new
  end
end
