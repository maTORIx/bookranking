class AuthorRelation < ApplicationRecord
  belongs_to :author
  belongs_to :book

  validates :book, uniqueness: {scope: :author}
end
