class Review < ApplicationRecord

  validates :point, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :user, uniqueness: {scope: :book}

  belongs_to :user
  belongs_to :book

  has_many :review_favorites
  has_many :users, through: :review_favorites

  after_create :update_book
  after_update :update_book

  after_create do
    user.up_reliability(:review)
  end

  def update_book
    @book = self.book
    @book.update_info
  end

  def has_permission?(user)
    user.id == self.user_id
  end

  def favorite(user)
    if self.review_favorites.exists?(user_id: user.id)
      return self.review_favorites.find_by(user_id: user.id).destroy
    else
      return self.review_favorites.create(user_id: user.id)
    end
  end

  def update_info
    @review = self
    @review.favorites_count = self.review_favorites.count
    @review.save!
  end
end
