class Run < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_runner ? controller.current_runner : nil }

  belongs_to :planned_run
  belongs_to :runner

  validates :runner, :date, :training_plan, presence: true

  #Catches the user trying to add duplicate dates per runner
  validates_uniqueness_of :date, :scope => :runner_id

  Run.public_activity_off
end
