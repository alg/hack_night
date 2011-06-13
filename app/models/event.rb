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

  before_save :reset_participants!

  def self.get(*args)
    Event.first || Event.new
  end

  def upcoming?
    !!(self.when and self.when > Time.now)
  end


  def reset_participants!
    if is_a_new_event?
      User.reset_participants!
    end
  end


  def is_a_new_event?
    e = Event.get
    self.when && self.when.future? and
      e.when.nil? || e.when.past?
  end
end
