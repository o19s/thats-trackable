class RenameGrouptrainingplansToPlannedRuns < ActiveRecord::Migration
  def change
    rename_table :grouptrainingplans, :planned_runs
  end
end
