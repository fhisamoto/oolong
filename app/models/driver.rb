class Driver < ActiveRecord::Base
  def is_available?
    status == "available"
  end
end
