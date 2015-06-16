class FixEmailsWithTrailingSpaces < ActiveRecord::Migration
  def change
  	Runner.find_each do | runner |
  		runner.email.strip!
  		runner.save!
  	end
  end
end
