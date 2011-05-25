class Location
  include Mongoid::Document

  field :name
  field :lat, :type => Float, :required => true
  field :lng, :type => Float, :required => true
  embedded_in :issue, :inverse_of => :locations
end
