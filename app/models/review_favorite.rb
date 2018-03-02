class ReviewFavorite < ApplicationRecord
  validates :user_id, uniqueness: {scope: :review_id}
  belongs_to :review
  belongs_to :user

  after_create do 
    self.user.up_reliability(:review_favorite)
    self.review.update_info
  end
end
