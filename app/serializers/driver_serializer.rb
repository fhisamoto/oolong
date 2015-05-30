class DriverSerializer < ActiveModel::Serializer
  attribute :id, :key => "driverId"
  attribute :is_available?, :key => "driverAvailable"
  attributes :latitude, :longitude
end