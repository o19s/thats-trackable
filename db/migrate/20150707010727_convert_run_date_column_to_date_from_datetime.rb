class ConvertRunDateColumnToDateFromDatetime < ActiveRecord::Migration
  def change
      change_column :runs, :date, :date

      rename_column :runs, :date, :date_string
      add_column :runs, :date, :date

      Run.reset_column_information
      Run.find_each { |run| run.update_attribute(:date, run.datestring) }
      remove_column :runs, :date_string

  end
end
