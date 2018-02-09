class EasyReview < ApplicationRecord
  belongs_to :books

  validates :ip_address, uniqueness: true

  after_create :update_book

  def update_book
    @book = self.book
    @book.easy_review_length = @book.easy_reviews.length
    @book.all_review_length = @book.easy_review_length + @book.review_length
    @book.easy_review_point = @book.easy_reviews.average(:point).to_f
    @book.save!
  end
end
