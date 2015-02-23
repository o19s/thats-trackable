class AddGrouptrainingplanIdToIndividualtrainingplans < ActiveRecord::Migration
  def change
    add_column :individualtrainingplans, :grouptrainingplans_id, :integer
  end
end
