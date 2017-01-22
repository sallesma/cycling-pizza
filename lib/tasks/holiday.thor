require 'thor/rails'

class Holiday < Thor
  include Thor::Rails

  desc "populate", "Populate french holidays"
  def populate
    puts 'Starting to populate...'

    HolidayPopulator.new.perform

    puts 'Finished to populate.'
  end

end
