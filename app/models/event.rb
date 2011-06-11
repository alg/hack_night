class Event
  include Mongoid::Document

  # field :date, :type => Date
  # field :time, :type => Time
  # field :address
  # field :phone
  # field :map_link

  # validates_presence_of :date

  field :when, :type => Time
  field :address
  field :phone

  validates_presence_of :when, :address, :phone

  def self.get(*args)
    Event.first || Event.new
  end
end
