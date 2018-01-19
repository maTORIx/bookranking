class Author < ApplicationRecord
  has_many :author_relations
  has_many :books, through: :author_relations
end
