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
end
