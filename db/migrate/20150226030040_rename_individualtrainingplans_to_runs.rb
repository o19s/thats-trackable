class RenameIndividualtrainingplansToRuns < ActiveRecord::Migration
  def change
    rename_table :individualtrainingplans, :runs
  end
end
