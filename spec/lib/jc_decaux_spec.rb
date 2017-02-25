require 'rails_helper'
require 'net/http'

describe JCDecaux do

  describe '#velib_stations' do

    context 'when returns an error' do
      it 'raises an exception containing the error' do
        forbidden = Net::HTTPResponse.new('1.1', '403', 'Forbidden')
        allow(forbidden).to receive(:body).and_return("{ \"error\" : \"Unauthorized\" }")

        allow(Net::HTTP).to receive(:get_response).and_return(forbidden)

        expect { JCDecaux.new.velib_stations }.to raise_error(JCDecaux::ApiError)
      end
    end

    context 'when returns ok' do
      it 'returns the result as json' do
        ok = Net::HTTPResponse.new('1.1', '200', 'OK')
        allow(ok).to receive(:body).and_return("[{\"number\":10002,\"name\":\"10002 - STRASBOURG\",\"address\":\"3 BD STRASBOURG - 75010 PARIS\",\"position\":{\"lat\":48.86967912445944,\"lng\":2.354327697377583},\"banking\":true,\"bonus\":false,\"status\":\"OPEN\",\"contract_name\":\"Paris\",\"bike_stands\":17,\"available_bike_stands\":2,\"available_bikes\":11,\"last_update\":1485008374000},{\"number\":8041, \"name\":\"08041 - CHAMPS ELYSEES LINCOLN\", \"address\":\"16 RUE DE LINCOLN - 75008 PARIS\", \"position\":{\"lat\":48.87069015790859, \"lng\":2.303222423974782}, \"banking\":true, \"bonus\":false, \"status\":\"OPEN\", \"contract_name\":\"Paris\", \"bike_stands\":38, \"available_bike_stands\":3, \"available_bikes\":35, \"last_update\":1485361180000}]")

        allow(Net::HTTP).to receive(:get_response).and_return(ok)

        response = JCDecaux.new.velib_stations
        expect(response).to eq([{"number"=>10002, "name"=>"10002 - STRASBOURG", "address"=>"3 BD STRASBOURG - 75010 PARIS", "position"=>{"lat"=>48.86967912445944, "lng"=>2.354327697377583}, "banking"=>true, "bonus"=>false, "status"=>"OPEN", "contract_name"=>"Paris", "bike_stands"=>17, "available_bike_stands"=>2, "available_bikes"=>11, "last_update"=>1485008374000},{"number"=>8041, "name"=>"08041 - CHAMPS ELYSEES LINCOLN", "address"=>"16 RUE DE LINCOLN - 75008 PARIS", "position"=>{"lat"=>48.87069015790859, "lng"=>2.303222423974782}, "banking"=>true, "bonus"=>false, "status"=>"OPEN", "contract_name"=>"Paris", "bike_stands"=>38, "available_bike_stands"=>3, "available_bikes"=>35, "last_update"=>1485361180000}])
      end
    end

  end

  describe '#velib_station' do

    context 'when returns ok' do
      it 'returns the result as json' do
        ok = Net::HTTPResponse.new('1.1', '200', 'OK')
        allow(ok).to receive(:body).and_return("{\"number\":10002,\"name\":\"10002 - STRASBOURG\",\"address\":\"3 BD STRASBOURG - 75010 PARIS\",\"position\":{\"lat\":48.86967912445944,\"lng\":2.354327697377583},\"banking\":true,\"bonus\":false,\"status\":\"OPEN\",\"contract_name\":\"Paris\",\"bike_stands\":17,\"available_bike_stands\":2,\"available_bikes\":11,\"last_update\":1485008374000}")

        allow(Net::HTTP).to receive(:get_response).and_return(ok)

        response = JCDecaux.new.velib_stations
        expect(response).to eq({"number"=>10002, "name"=>"10002 - STRASBOURG", "address"=>"3 BD STRASBOURG - 75010 PARIS", "position"=>{"lat"=>48.86967912445944, "lng"=>2.354327697377583}, "banking"=>true, "bonus"=>false, "status"=>"OPEN", "contract_name"=>"Paris", "bike_stands"=>17, "available_bike_stands"=>2, "available_bikes"=>11, "last_update"=>1485008374000})
      end
    end

  end

end
