class Driver < ActiveRecord::Base
  def available?
    driver_available
  end
end
