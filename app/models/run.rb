class Run < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  
  belongs_to :planned_run
  belongs_to :runner

  #Catches the user trying to add duplicate dates per runner
  validates_uniqueness_of :date, :scope => :runner_id
end
