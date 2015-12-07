class ChangeChangedFlagToBoolean < ActiveRecord::Migration
  def change
    change_column :runs, :changed_flag, 'boolean USING CAST(changed_flag AS boolean)'
  end
end
