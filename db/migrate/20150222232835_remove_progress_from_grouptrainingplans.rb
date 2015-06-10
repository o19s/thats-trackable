class RemoveProgressFromGrouptrainingplans < ActiveRecord::Migration
  def change
    remove_column :grouptrainingplans, :progress, :text
  end
end
