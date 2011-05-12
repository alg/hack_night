class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :body

  belongs_to :author, :as => User

  validates_presence_of :body
  validates_presence_of :author_id

  def self.for_board
    #TODO: load last N or all unread or <some other criteria> messages
    asc :created_at
  end
end
