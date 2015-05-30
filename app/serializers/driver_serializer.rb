class DriverSerializer < ActiveModel::Serializer
  attribute :id, :key => "driverId"
  attribute :driver_available, :key => "driverAvailable"
  attributes :latitude, :longitude
end