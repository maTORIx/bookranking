class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  after_save do
    @book = self.book 
    @book.review_point = self.book.reviews.average(:point).to_f
    @book.save!
  end

  after_create do
    @book = self.book
    @book.review_length = @book.reviews.length
    @book.save!
  end

  def has_permission?(user)
    user.id == self.user_id
  end
end
