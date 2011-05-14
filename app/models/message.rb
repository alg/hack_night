class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :body

  belongs_to :author, :as => User

  validates_presence_of :body
  validates_presence_of :author_id

  def self.for_board
    desc(:created_at).limit(5)
  end
end
