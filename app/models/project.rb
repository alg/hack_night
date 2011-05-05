class Project
  include Mongoid::Document

  field :name,         :type => String
  field :description,  :type => String
  field :slots_number, :type => String

  validates_presence_of :name, :description, :slots_number
  validates_numericality_of :slots_number
end
