require 'rails_helper'

describe Driver, :type => :model do
  describe '.are_available' do
    let!(:available_driver) { Driver.create! :driver_available => true }
    let!(:unavailable_driver) { Driver.create! :driver_available => false }

    it "includes available driver" do
      expect(Driver.are_available.all).to include(available_driver)
    end

    it "does not includes unavailable driver" do
      expect(Driver.are_available.all).to_not include(unavailable_driver)
    end
  end
end