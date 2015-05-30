require 'rails_helper'

describe Driver, :type => :model do
  describe '.in_bounds' do
    let(:sw) { Geokit::LatLng.new(-23.7100, -46.7100) }
    let(:ne) { Geokit::LatLng.new(-23.5500, -46.6500) }

    let!(:in_bound_driver) { Driver.create! :latitude => -23.5949, :longitude => -46.6902 }
    let!(:out_bound_driver) { Driver.create! :latitude => -23.7200, :longitude => -46.7000 }

    it "contains one in bound driver" do
      expect(Driver.in_bounds([sw, ne]).all).to include(in_bound_driver)
    end
  end
end