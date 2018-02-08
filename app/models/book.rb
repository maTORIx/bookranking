class Book < ApplicationRecord
  mount_uploader :cover_image, BookCoverUploader

  has_many :reviews

  has_many :author_relations
  has_many :authors , through: :author_relations
  
  has_many :tag_relations
  has_many :tags, through: :tag_relations

  has_many :category_relations
  has_many :categories, through: :category_relations
  
  has_many :stars

  has_many :book_shelf_relations

  def add_author(name)
    @author = Author.find_or_create_by!(name: name)
    self.author_relations.find_or_create_by!(author_id: @author.id)
  end

  def self.classifiers
    {
      simple_point: "点",
      review_point: "点",
      review_length: "件",
      star_length: "件",
      shelfed_length: "件"
    }
  end

  def self.column_names
    {
      simple_point: "Star評価",
      review_point: "レビュー評価",
      review_length: "レビュー件数",
      star_length: "Star件数",
      shelfed_length: "本棚に入れた数"
    }
  end

end
