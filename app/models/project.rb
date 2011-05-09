class Project

  include Mongoid::Document

  field :name
  field :description
  field :slots

  references_many :members, :class_name => "User"

  validates_presence_of :name, :description, :slots
  validates_numericality_of :slots

end
