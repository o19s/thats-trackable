class CreateIndividualtrainingplans < ActiveRecord::Migration
  def change
    create_table :individualtrainingplans do |t|
      t.integer :runner_id
      t.string :date
      t.text :trainingplan
      t.text :progress

      t.timestamps null: false
    end
  end
end
