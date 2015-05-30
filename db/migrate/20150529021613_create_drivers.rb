class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :driver_available
      t.timestamps
    end
  end
end
