require 'rails_helper'
require 'net/http'

describe WebCal do
  describe '#french_holidays' do

    context 'when returns ok' do
      it 'returns the result as json' do
        ok = Net::HTTPResponse.new('1.1', '200', 'OK')
        allow(ok).to receive(:body).and_return("[{\"date\":\"2015-01-01\", \"name\":\"Premier de l'an\", \"alternate_names\":\"Jour de l'an\", \"url\":\"https://fr.wikipedia.org/wiki/Jour_de_l%27an\", \"description\":\"Le Jour de l'an...\"}]")
        allow(Net::HTTP).to receive(:get_response).and_return(ok)

        response = WebCal.new.french_holidays
        expect(response).to eq([{"date"=>"2015-01-01", "name"=>"Premier de l'an", "alternate_names"=>"Jour de l'an", "url"=>"https://fr.wikipedia.org/wiki/Jour_de_l%27an", "description"=>"Le Jour de l'an..."}])
      end
    end
  end

end
