class PlannedRun < ActiveRecord::Base
  belongs_to :group
  has_many :runs, dependent: :destroy

  #Catches the user trying to create multiple planned_runs for the same day for the same group
  validates_uniqueness_of :date, :scope => :group_id
end
