class Issue
  include Mongoid::Document

  before_save :slugify

  field :title
  field :slug
  field :description
  embeds_many :locations
  embeds_many :comments
  referenced_in :user
  embeds_many :pics

  validates_presence_of :title, :description, :user
  validate :atleast_one_pic

  def atleast_one_pic
    self.errors.add :pics, "Need atleast one pic" unless self.pics.all.count > 0
  end

  def slugify 
    self.slug = self.title.slugify
  end
end
