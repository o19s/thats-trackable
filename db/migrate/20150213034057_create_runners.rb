class CreateRunners < ActiveRecord::Migration
  def change
    create_table :runners do |t|
      t.string :name
      t.integer :group_id
      t.string :role

      t.timestamps null: false
    end
  end
end
