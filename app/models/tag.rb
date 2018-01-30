class Tag < ApplicationRecord
  has_many :tag_relations
  has_many :books, through: :tag_relations

  def self.find_books_id(tags)
    TagRelation.where(tag_id: Tag.where(name: tags).pluck(:id)).pluck(:book_id).uniq 
  end

  def self.find_books(tags)
    Book.where(id: Tag.find_book_id(tags))
  end
end
