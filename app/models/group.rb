class Group < ActiveRecord::Base
  has_many :runners
  has_many :grouptrainingplans
end
