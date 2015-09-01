class ChangeChangedFlagToCustomizeFlag < ActiveRecord::Migration
  def change
    rename_column :runs, :changed_flag, :customize_flag
  end
end
