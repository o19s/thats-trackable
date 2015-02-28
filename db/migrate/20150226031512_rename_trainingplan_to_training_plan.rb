class RenameTrainingplanToTrainingPlan < ActiveRecord::Migration
  def change
    rename_column :planned_runs, :trainingplan, :training_plan
    rename_column :runs, :trainingplan, :training_plan
  end
end
