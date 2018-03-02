class ReviewFavorite < ApplicationRecord
  validates :user_id, uniqueness: {scope: :review_id}
  belongs_to :review
  belongs_to :user
end
