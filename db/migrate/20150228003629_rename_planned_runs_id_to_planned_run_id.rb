class RenamePlannedRunsIdToPlannedRunId < ActiveRecord::Migration
  def change
    rename_column :runs, :planned_runs_id, :planned_run_id
  end
end
