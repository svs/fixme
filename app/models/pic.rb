class Pic
  include Mongoid::Document
  include Mongoid::Timestamps

  field :caption
  mount_uploader :pic, IssuePicUploader

  validates_presence_of :caption

end
