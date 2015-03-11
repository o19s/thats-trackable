class ChangeTextToDate < ActiveRecord::Migration
  def change
    change_column :planned_runs, :date, :date
  end
end
