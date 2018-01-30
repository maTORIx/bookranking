class Author < ApplicationRecord
  has_many :author_relations
  has_many :books, through: :author_relations

  def self.find_books_id(authors)
    AuthorRelation.where(author_id: Author.where(name: authors).pluck(:id)).pluck(:book_id).uniq
  end

  def self.find_books(authors)
    Book.where(id: Author.find_book_id(authors))
  end
end
