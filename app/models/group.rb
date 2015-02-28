class Group < ActiveRecord::Base
  has_many :runners
  has_many :planned_runs
end
