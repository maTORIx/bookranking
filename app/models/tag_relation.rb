class TagRelation < ApplicationRecord
  belongs_to :tag
  belongs_to :book
  has_many :tag_votes
end
