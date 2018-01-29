class Book < ApplicationRecord
  mount_uploader :cover_image, BookCoverUploader

  has_many :reviews

  has_many :author_relations
  has_many :authors , through: :author_relations
  
  has_many :tag_relations
  has_many :tags, through: :tag_relations

  has_many :category_relations
  has_many :category, through: :category_relations
  
  has_many :stars

  has_many :book_shelf_relations

  def add_author(name)
    @author = Author.find_or_create_by!(name: name)
    self.author_relations.find_or_create_by!(author_id: @author.id)
  end

end
