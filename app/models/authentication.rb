class Authentication
  include Mongoid::Document

  field :provider
  field :uid
  
  referenced_in :user, :inverse_of => :authentications

  def self.find_from_auth_info(auth)
    where(:provider => auth['provider']).and(:uid => auth['uid']).first
  end
  
  def self.create_from_auth_info!(auth, user = nil)
    user ||= User.create_from_auth_info!(auth)
    user.authentications.create!(:provider => auth['provider'], :uid => auth['uid'])
  end
  
end
