class ConvertRunDateColumnToTrueDateType < ActiveRecord::Migration
 def self.up
    change_column :runs, :date, :datetime

  end

  def self.down
    change_column :runs, :date, :string
  end
end
