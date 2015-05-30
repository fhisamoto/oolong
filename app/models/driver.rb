class Driver < ActiveRecord::Base
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  scope :are_available, -> { where(driver_available: true) }

  def available?
    driver_available
  end
end
