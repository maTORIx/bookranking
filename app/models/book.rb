class Book < ApplicationRecord
  mount_uploader :cover_image, BookCoverUploader

  has_many :reviews

  has_many :author_relations
  has_many :authors , through: :author_relation
  
  has_many :tag_relations
  has_many :tags, through: :tag_relations

  has_many :category_relations
  has_many :category, through: :category_relations
  
  has_many :stars

end
