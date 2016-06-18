class Run < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_runner ? controller.current_runner : nil }

  scope :sorted, order(:date => :desc)

  belongs_to :planned_run
  belongs_to :runner

  # We don't require a run be tied to a training_plan or a #planned_run
  #validates :runner, :date, :training_plan, presence: true
  validates :runner, :date, presence: true

  #Catches the user trying to add duplicate dates per runner
  validates_uniqueness_of :date, :scope => :runner_id

  acts_as_commontable

  Run.public_activity_off
end
