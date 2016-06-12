class AddActiveToRunner < ActiveRecord::Migration
  def change
    add_column :runners, :active, :boolean
  end
end
