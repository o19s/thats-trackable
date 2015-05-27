class AddUsernameToRunner < ActiveRecord::Migration
  def change
    add_column :runners, :username, :string
  end
end
