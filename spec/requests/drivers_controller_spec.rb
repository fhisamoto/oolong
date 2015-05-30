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
end