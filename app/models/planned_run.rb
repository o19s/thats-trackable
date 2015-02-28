class PlannedRun < ActiveRecord::Base
  belongs_to :group
  has_many :runs, dependent: :destroy
end
