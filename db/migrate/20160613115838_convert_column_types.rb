class ConvertColumnTypes < ActiveRecord::Migration
  def change
    change_column :runs, :duration, :string
    change_column :runs, :pace, :string
    change_column :runs, :mileage, :string

  end
end
