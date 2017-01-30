require 'rails_helper'

describe VelibStationsUpdater do
  let(:velib_stations_updater) { VelibStationsUpdater.new }

  context 'when no stations in db' do
    context 'when no argument' do
      it 'creates all the stations' do
        expect_any_instance_of(JCDecaux).to receive(:velib_stations).and_return([{"number"=>10002, "name"=>"10002 - STRASBOURG", "address"=>"3 BD STRASBOURG - 75010 PARIS", "position"=>{"lat"=>48.86967912445944, "lng"=>2.354327697377583}, "banking"=>true, "bonus"=>false, "status"=>"OPEN", "contract_name"=>"Paris", "bike_stands"=>17, "available_bike_stands"=>2, "available_bikes"=>11, "last_update"=>1485008374000},{"number"=>8041, "name"=>"08041 - CHAMPS ELYSEES LINCOLN", "address"=>"16 RUE DE LINCOLN - 75008 PARIS", "position"=>{"lat"=>48.87069015790859, "lng"=>2.303222423974782}, "banking"=>true, "bonus"=>false, "status"=>"OPEN", "contract_name"=>"Paris", "bike_stands"=>38, "available_bike_stands"=>3, "available_bikes"=>35, "last_update"=>1485361180000}])

        velib_stations_updater.perform

        expect(Station.count).to eq(2)

        first = Station.first
        expect(first.number).to eq('10002')
        expect(first.contract_name).to eq('Paris')
        expect(first.name).to eq('10002 - STRASBOURG')
        expect(first.address).to eq('3 BD STRASBOURG - 75010 PARIS')
        expect(first.latitude).to be_within(0.0001).of(48.86967912445944)
        expect(first.longitude).to be_within(0.0001).of(2.354327697377583)
        expect(first.banking).to eq(true)
        expect(first.bonus).to eq(false)
        expect(first.station_statuses.last.status).to eq('OPEN')
        expect(first.station_statuses.last.stands).to eq(17)
        expect(first.station_statuses.last.available_bikes).to eq(11)
        expect(first.station_statuses.last.available_stands).to eq(2)
        expect(first.station_statuses.last.last_update_at).to eq(Time.at(1485008374))

        last = Station.last
        expect(last.number).to eq('8041')
        expect(last.contract_name).to eq('Paris')
        expect(last.name).to eq('08041 - CHAMPS ELYSEES LINCOLN')
        expect(last.address).to eq('16 RUE DE LINCOLN - 75008 PARIS')
        expect(last.latitude).to be_within(0.0001).of(48.87069015790859)
        expect(last.longitude).to be_within(0.0001).of(2.303222423974782)
        expect(last.banking).to eq(true)
        expect(last.bonus).to eq(false)
        expect(last.station_statuses.last.status).to eq('OPEN')
        expect(last.station_statuses.last.stands).to eq(38)
        expect(last.station_statuses.last.available_bikes).to eq(35)
        expect(last.station_statuses.last.available_stands).to eq(3)
        expect(last.station_statuses.last.last_update_at).to eq(Time.at(1485361180))
      end
    end

    context 'when a list of stations passed as argument' do
      it 'creates the corresponding the stations' do
        expect_any_instance_of(JCDecaux).to receive(:velib_station).with('10002').and_return({"number"=>10002, "name"=>"10002 - STRASBOURG", "address"=>"3 BD STRASBOURG - 75010 PARIS", "position"=>{"lat"=>48.86967912445944, "lng"=>2.354327697377583}, "banking"=>true, "bonus"=>false, "status"=>"OPEN", "contract_name"=>"Paris", "bike_stands"=>17, "available_bike_stands"=>2, "available_bikes"=>11, "last_update"=>1485008374000})
        expect_any_instance_of(JCDecaux).to receive(:velib_station).with('8041').and_return({"number"=>8041, "name"=>"08041 - CHAMPS ELYSEES LINCOLN", "address"=>"16 RUE DE LINCOLN - 75008 PARIS", "position"=>{"lat"=>48.87069015790859, "lng"=>2.303222423974782}, "banking"=>true, "bonus"=>false, "status"=>"OPEN", "contract_name"=>"Paris", "bike_stands"=>38, "available_bike_stands"=>3, "available_bikes"=>35, "last_update"=>1485361180000})

        velib_stations_updater.perform(['10002', '8041'])

        expect(Station.count).to eq(2)

        first = Station.first
        expect(first.number).to eq('10002')
        expect(first.contract_name).to eq('Paris')
        expect(first.name).to eq('10002 - STRASBOURG')
        expect(first.address).to eq('3 BD STRASBOURG - 75010 PARIS')
        expect(first.latitude).to be_within(0.0001).of(48.86967912445944)
        expect(first.longitude).to be_within(0.0001).of(2.354327697377583)
        expect(first.banking).to eq(true)
        expect(first.bonus).to eq(false)
        expect(first.station_statuses.last.status).to eq('OPEN')
        expect(first.station_statuses.last.stands).to eq(17)
        expect(first.station_statuses.last.available_bikes).to eq(11)
        expect(first.station_statuses.last.available_stands).to eq(2)
        expect(first.station_statuses.last.last_update_at).to eq(Time.at(1485008374))

        last = Station.last
        expect(last.number).to eq('8041')
        expect(last.contract_name).to eq('Paris')
        expect(last.name).to eq('08041 - CHAMPS ELYSEES LINCOLN')
        expect(last.address).to eq('16 RUE DE LINCOLN - 75008 PARIS')
        expect(last.latitude).to be_within(0.0001).of(48.87069015790859)
        expect(last.longitude).to be_within(0.0001).of(2.303222423974782)
        expect(last.banking).to eq(true)
        expect(last.bonus).to eq(false)
        expect(last.station_statuses.last.status).to eq('OPEN')
        expect(last.station_statuses.last.stands).to eq(38)
        expect(last.station_statuses.last.available_bikes).to eq(35)
        expect(last.station_statuses.last.available_stands).to eq(3)
        expect(last.station_statuses.last.last_update_at).to eq(Time.at(1485361180))
      end
    end
  end

  context 'when stations exist' do
    it 'updates the station and creates a new status' do
      station = FactoryGirl.create(:station_with_statuses, statuses_count: 2)
      # Only changing the bonus field
      expect_any_instance_of(JCDecaux).to receive(:velib_station).with(station.number).and_return({"number"=>station.number, "name"=>station.name, "address"=>station.address, "position"=>{"lat"=>station.latitude, "lng"=>station.longitude}, "banking"=>station.banking, "bonus"=>!station.bonus, "status"=>"OPEN", "contract_name"=>station.contract_name, "bike_stands"=>17, "available_bike_stands"=>2, "available_bikes"=>11, "last_update"=>1485008374000})

      previous_bonus = station.bonus
      previous_statuses_count = station.station_statuses.count

      velib_stations_updater.perform([station.number])
      station.reload

      expect(station.bonus).not_to eq(previous_bonus)
      expect(station.station_statuses.count).to eq(previous_statuses_count + 1)
    end
  end
end
