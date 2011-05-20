class Event
  include Mongoid::Document

  field :date, :type => Date
  field :time, :type => Time
  field :address
  field :phone
  field :map_link

  validates_presence_of :date
end
