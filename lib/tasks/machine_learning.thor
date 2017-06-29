require 'thor/rails'

class MachineLearning < Thor
  include Thor::Rails

  desc "extract", "Extract features for machine learning"
  def extract
    puts 'Starting to extract...'

    Extractor::Extractor.new.perform

    puts 'Finished to extract.'
  end

end
