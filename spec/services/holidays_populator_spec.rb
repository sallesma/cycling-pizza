require 'rails_helper'

describe HolidaysPopulator do
  let(:holidays_populator) { HolidaysPopulator.new }

  context 'when the api returns an array of holidays' do
    it 'creates the associated holidays' do
      allow_any_instance_of(WebCal).to receive(:french_holidays).and_return([{"date"=>"2015-01-01", "name"=>"Premier de l'an", "alternate_names"=>"Jour de l'an", "url"=>"https://fr.wikipedia.org/wiki/Jour_de_l%27an", "description"=>"Le Jour de l'an..."},{"date"=>"2015-12-25", "name"=>"Noel"}])

      holidays_populator.perform

      expect(Holiday.count).to eq(2)

      first = Holiday.first
      expect(first.date).to eq(Date.new(2015,01,01))
      expect(first.country).to eq('FR')
      expect(first.name).to eq('Premier de l\'an')

      last = Holiday.last
      expect(last.date).to eq(Date.new(2015,12,25))
      expect(last.country).to eq('FR')
      expect(last.name).to eq('Noel')
    end
  end
end
