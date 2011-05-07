class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email
  field :name
  field :location
  field :nickname
  field :image

  references_many :authentications, :dependent => :destroy

#  devise :rememberable, :token_authenticatable, :oauthable
  devise :omniauthable

  def self.create_from_auth_info!(auth)
    ui = auth['user_info']
    create!({
      :name     => ui['name'],
      :location => ui['location'],
      :nickname => ui['nickname'],
      :image    => ui['image'] })
  end

end
