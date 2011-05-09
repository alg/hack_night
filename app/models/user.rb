class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :location
  field :nickname
  field :image

  references_many :authentications, :dependent => :destroy
  referenced_in :project, :inverse_of => :members

  devise :omniauthable, :token_authenticatable, :rememberable

  validates_presence_of :name
  validates_presence_of :nickname

  def self.create_from_auth_info!(auth)
    ui = auth['user_info']
    create!({
      :name     => ui['name'],
      :location => ui['location'],
      :nickname => ui['nickname'],
      :image    => ui['image'] })
  end


  def to_s
    nickname
  end

end
