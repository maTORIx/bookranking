class Author < ApplicationRecord
  validates :name, uniqueness: true
  has_many :author_relations
  has_many :books, through: :author_relations

  def self.find_books_id(authors)
    result = []
    ids = AuthorRelation.where(author_id: Author.where(name: authors).pluck(:id)).pluck(:book_id)
    ids.each do |id|
      if ids.count(id) == authors.length
        result.push(id)
      end
    end

    result.uniq
  end

  def self.find_books(authors)
    Book.where(id: Author.find_books_id(authors))
  end

  def create_request(book)
    book.book_edit_requests.create(target_column: "author", action: "create", content: self.name)
  end

  def detroy_request(book)
    book.book_edit_requests.create(target_column: "author", action: "destroy", content: self.name)
  end
end
