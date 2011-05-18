class Link
  
  include Mongoid::Document
  
  field :label
  field :url
  
  embedded_in :project
  
  validates_presence_of :label
  validates_presence_of :url

end