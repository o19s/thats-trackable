class Runner < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :name, uniqueness: true

  belongs_to :group
  has_one :facebook_user
  has_many :runs, dependent: :destroy
  has_secure_password

  def Runner.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def activity_sparkline
    today = Date.today
    results = self.runs.collect do |r|
      if r.date > today
        0
      else
        r.progress.blank? ? -1 : 1
      end
    end
    results.join(",")
  end
end
