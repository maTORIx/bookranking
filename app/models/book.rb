class Book < ApplicationRecord
  mount_uploader :cover_image, BookCoverUploader

  has_many :reviews

  has_many :author_relations
  has_many :authors , through: :author_relations
  
  has_many :tag_relations
  has_many :tags, through: :tag_relations

  has_many :category_relations
  has_many :categories, through: :category_relations

  has_many :easy_reviews

  has_many :book_shelf_relations

  has_many :book_edit_requests

  def self.classifiers
    {
      all_review_point: "点",
      review_point: "点",
      all_review_length: "件",
      review_length: "件",
      shelfed_length: "件"
    }
  end

  def self.column_japanese_names
    {
      all_review_point: "総合レビュー評価",
      review_point: "レビュー評価",
      all_review_length: "総合レビュー件数",
      review_length: "レビュー件数",
      shelfed_length: "本棚に入れた数"
    }
  end

  def generate_all_review_point
    (self.easy_review_length * self.easy_review_point + (self.review_length * 2) * self.review_point) / (self.easy_review_length + (self.review_length * 2))
  end

  def generate_score
    self.all_review_point * 20
  end

  def update_info
    @book = self
    @book.easy_review_length = @book.easy_reviews.length
    @book.easy_review_point = @book.easy_reviews.average(:point).floor(3).to_f

    @book.review_length = @book.reviews.length
    @book.review_point = @book.reviews.average(:point).floor(3).to_f

    @book.all_review_length = @book.easy_review_length + @book.review_length
    @book.all_review_point = @book.generate_all_review_point.floor(3).to_f
    @book.score = @book.generate_score

    @book.save!
  end

  def edit_request(params)
    for key in params
      if Book.column_names.include?(key) && self[key.to_sym].to_s != params[key.to_sym]
        self.book_edit_requests.create(target_column: key.to_s, action: "update", content: params[key.to_sym])
      end
    end
  end

end
