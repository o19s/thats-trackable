class CreateGrouptrainingplans < ActiveRecord::Migration
  def change
    create_table :grouptrainingplans do |t|
      t.string :date
      t.integer :group_id
      t.text :trainingplan
      t.text :progress

      t.timestamps null: false
    end
  end
end
