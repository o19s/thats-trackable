class Individualtrainingplan < ActiveRecord::Base
  has_many :runners
  belongs_to :grouptrainingplan
end
