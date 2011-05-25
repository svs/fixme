class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comment
  references_one :user
end
