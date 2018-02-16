class Category < ApplicationRecord
  has_many :category_relations
  has_many :books, through: :category_relation

  def self.find_books_id(categories)
    result = []
    ids = CategoryRelation.where(category_id: Category.where(name: categories).pluck(:id)).pluck(:book_id)
    ids.each do |id| 
      if ids.count(id) == categories.length
        result.push(id)
      end
    end
    result.uniq
  end

  def self.find_books(categories)
    Book.where(id: self.find_books_id(categories))
  end

  def create_request(book, name)
    book.book_edit_requests.create(target_column: "category", action: "create", content: self.name)
  end

  def detroy_request(book, name)
    book.book_edit_requests.create(target_column: "category", action: "destroy", content: self.name)
  end
end
