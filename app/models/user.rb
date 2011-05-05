class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :location
  field :nickname
  field :image
  
  references_many :authentications, :dependent => :destroy
  
  devise :rememberable, :trackable

  def self.create_from_auth_info!(auth)
    ui = auth['user_info']
    create!({
      :name     => ui['name'],
      :location => ui['location'],
      :nickname => ui['nickname'],
      :image    => ui['image'] })
  end
  
end