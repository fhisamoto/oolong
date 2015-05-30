require 'rails_helper'

describe DriversController, :type => :request do

  describe 'POST #status' do
    let!(:driver) { Driver.create! }

    let(:driver_params) do
      {
        :id => driver.id,
        :format => "json",
        :driver => {
          :latitude => -23.60810717,
          :longitude => -46.67500346,
          :driverAvailable => true,
          :driverId => driver.id
        }
      }
    end

    before { post status_driver_url driver_params }

    it { expect(response).to be_success }

    it { expect(driver.reload.latitude).to eql(-23.60810717) }
    it { expect(driver.reload.longitude).to eql(-46.67500346) }
    it { expect(driver.reload).to be_available }
  end

  describe 'GET #status' do
    let!(:driver) do
      Driver.create! :latitude => -23.60810717, :longitude => -46.67500346, :driver_available => true
    end

    let(:driver_params) { { :id => driver.id } }

    before { get status_driver_url driver_params }

    it { expect(response).to be_success }
    it { expect(response.body).to match(/\"driverId\":#{driver.id}/) }
    it { expect(response.body).to match(/\"driverAvailable\":true/) }
    it { expect(response.body).to match(/\"latitude\":\"-23.60810717\"/) }
    it { expect(response.body).to match(/\"longitude\":\"-46.67500346\"/) }
  end

  describe 'GET #inArea' do
    context 'Successful request' do
      let!(:in_area_driver) do
        Driver.create! :latitude => -23.5949, :longitude => -46.6902, :driver_available => true
      end

      let!(:unavailable_driver) do
        Driver.create! :latitude => -23.5948, :longitude => -46.6901, :driver_available => false
      end

      let!(:outside_area_driver) do
        Driver.create! :latitude => -23.7200, :longitude => -46.7000, :driver_available => true
      end

      before { get inArea_drivers_url :sw => "-23.7100,-46.7100", :ne => "-23.5500,-46.6500" }

      it { expect(response).to be_success }
      it { expect(response.body).to match(/\"driverId\":#{in_area_driver.id}/) }
      it { expect(response.body).to_not match(/\"driverId\":#{outside_area_driver.id}/) }

      it "does not return unavailable driver" do
        expect(response.body).to_not match(/\"driverId\":#{unavailable_driver.id}/)
      end
    end

    context 'Malformed request' do
      before { get inArea_drivers_url :sw => "-23.7100", :ne => "-23.5500,-46.6500" }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'POST #drivers' do
    before { post drivers_url :driver => { :name => "Gumercindo Silva" } }

    it { expect(response).to be_success }
    it { expect(Driver.first.name).to eql("Gumercindo Silva") }
  end
end