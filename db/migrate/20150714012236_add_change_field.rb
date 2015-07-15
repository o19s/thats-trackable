class AddChangeField < ActiveRecord::Migration
  def change
    add_column :runs, :changed_flag, :integer
  end
end
