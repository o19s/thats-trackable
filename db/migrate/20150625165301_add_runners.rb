class AddRunners < ActiveRecord::Migration
  def change
  	json = ActiveSupport::JSON.decode(File.read('./db/migrate/runners.json'))
  	values = json['values']
  	values.each do |value|
  	  Runner.create(:role=>value[3], :name=>value[1], :email=>value[6], :password=>"password", :group_id=>1)
  	end


  end
end
