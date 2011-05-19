class Project

  include Mongoid::Document

  field :name
  field :description
  field :slots, :type => Integer, :default => 4

  references_many :members, :class_name => "User", :inverse_of => :project, :autosave => true
  referenced_in   :originator, :class_name => "User", :inverse_of => :suggested_projects
  embeds_many     :links

  validates_presence_of     :name
  validates_presence_of     :originator
  validates_numericality_of :slots

  def self.upcoming
    User.where(:participating? => true).map(&:project).uniq.compact
  end
  
  def has_vacant_slots?
    self.slots > self.members.count
  end
  
end
