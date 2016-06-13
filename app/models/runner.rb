class Runner < ActiveRecord::Base
  scope :active, -> { where(active: true) }
  
  validates :email, uniqueness: true
  validates :name, uniqueness: true

  belongs_to :group
  has_one :facebook_user
  has_many :runs, dependent: :destroy
  has_secure_password

  acts_as_commontator

  def Runner.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
