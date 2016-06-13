class AddDurationPaceMileageToRun < ActiveRecord::Migration
  def change
    add_column :runs, :duration, :int
    add_column :runs, :pace, :int
    add_column :runs, :mileage, :float
  end
end
