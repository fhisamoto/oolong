class AddsNameToDriver < ActiveRecord::Migration
  def change
    add_column :drivers, :name, :string
  end
end
