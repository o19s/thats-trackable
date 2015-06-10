class Runner < ActiveRecord::Base
  belongs_to :group
  has_many :runs, dependent: :destroy
  has_secure_password

  def Runner.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
