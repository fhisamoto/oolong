class AddsCarPlate < ActiveRecord::Migration
  def change
    add_column :drivers, :car_plate, :string
  end
end
