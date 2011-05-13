class Project

  include Mongoid::Document

  field :name
  field :description
  field :slots, :type => Integer, :default => 4

  references_many :members, :class_name => "User"

  validates_presence_of     :name
  validates_numericality_of :slots

end
