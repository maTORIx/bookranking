class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, uniqueness: {scope: :book}

  after_create :update_book

  def update_book
    @book = self.book
    @book.review_length = @book.reviews.length
    @book.review_point = @book.reviews.average(:point).to_f
    @book.all_review_length = @book.easy_review_length + @book.review_length
    @book.all_review_point = @book.generate_all_review_point
     
    @book.save!
  end

  def has_permission?(user)
    user.id == self.user_id
  end
end
