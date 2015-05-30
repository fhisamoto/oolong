require 'rails_helper'

describe DriversController, :type => :request do

  let!(:driver) { Driver.create! :status => "available" }

  describe 'POST #status' do
    before { post status_driver_path :id => driver.id }

    it { expect(response).to be_success }
    it { expect(response.body).to match(/\"driverId\":#{driver.id}/) }
    it { expect(response.body).to match(/\"driverAvailable\":true/) }
    it { expect(response.body).to match(/\"latitude\":/) }
    it { expect(response.body).to match(/\"longitude\":/) }
  end
end