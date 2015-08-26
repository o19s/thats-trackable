class ChangeChangedFlagToBoolean < ActiveRecord::Migration
  def change
    change_column :runs, :changed_flag, :boolean
  end
end
