class Message
  include Mongoid::Document

  field :body

  belongs_to :author, :as => User

  validates_presence_of :body
  validates_presence_of :author_id
end
