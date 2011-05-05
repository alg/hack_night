class Project
  include Mongoid::Document

  field :name
  field :description
  field :slots_number

  validates_presence_of :name, :description, :slots_number
  validates_numericality_of :slots_number
end
