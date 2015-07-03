class FacebookUser < ActiveRecord::Base
  belongs_to :runner

  class << self
    def from_omniauth(auth)
      user = FacebookUser.find_or_initialize_by(uid: auth['uid'])
      user.name = auth['info']['name']
      user.avatar_url = auth['info']['image']
      user.save!
      user
    end
  end
end


