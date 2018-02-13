class EasyReview < ApplicationRecord
  validates :point, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :ip_address, uniqueness: {scope: :book_id}

  belongs_to :book

  after_create :update_book

  def update_book
    @book = self.book
    @book.easy_review_length = @book.easy_reviews.length
    @book.all_review_length = @book.easy_review_length + @book.review_length
    @book.easy_review_point = @book.easy_reviews.average(:point).to_f
    @book.save!
  end
end
