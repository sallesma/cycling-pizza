require 'csv'

class Extractor::Extractor

  CSV_FILE = 'stations_features.csv'

  def perform
    CSV.open(CSV_FILE, "w") do |csv|
      Station.find_each do |station|
        features = Extractor::StationFeatures.new(station)
        result = features.compute

        csv << result.data if result.success?
      end
    end
  end
end
