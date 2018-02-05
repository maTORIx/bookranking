class Tag < ApplicationRecord
  has_many :tag_relations
  has_many :books, through: :tag_relations

  def self.find_books_id(tags)
    result = []
    ids = TagRelation.where(tag_id: Tag.where(name: tags).pluck(:id)).pluck(:book_id) 
    ids.each do |id|
      if ids.count(id) == tags.length
        result.push(id)
      end
    end

    result.uniq
  end

  def self.find_books(tags)
    Book.where(id: Tag.find_books_id(tags))
  end
end
