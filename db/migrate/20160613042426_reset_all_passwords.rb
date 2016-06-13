class ResetAllPasswords < ActiveRecord::Migration
  # reset all passwors in the system for the new year.
  def change
    Runner.find_each do |runner|
      runner.password = 'password'
      runner.save!
    end
  end
end
