class Tag < ApplicationRecord
  has_many :tag_relations
  has_many :books, through: :tag_relations

  def self.find_books_id(tags)
    result = []
    ids = TagRelation.where(tag_id: Tag.where(name: tags).pluck(:id), alive: true).order(score: "desc").pluck(:book_id) 
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

  def update_info
    self.votes_length = self.tag_relations.all.sum(:votes_length)
    self.save
  end

  def self.update_info
    Tag.all.each {|t| t.update_info}
  end
end
