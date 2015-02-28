class RenameGrouptrainingplansIdToPlannedRunsId < ActiveRecord::Migration
  def change
    rename_column :runs, :grouptrainingplans_id, :planned_runs_id
  end
end
