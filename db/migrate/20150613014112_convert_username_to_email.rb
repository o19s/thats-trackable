class ConvertUsernameToEmail < ActiveRecord::Migration
  def change
    rename_column :runners, :username, :email
  end
end
