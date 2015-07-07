class ConvertRunDateColumnToDateFromDatetime < ActiveRecord::Migration
  def change
      change_column :runs, :date, :date
  end
end
