class Run < ActiveRecord::Base
  has_many :runners
  belongs_to :planned_run
end
