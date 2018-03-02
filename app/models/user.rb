class User < ApplicationRecord
  has_secure_password
  before_create :generate_confirm_hash
  after_create :email_confirm

  validates :email, presence: true, uniqueness: true, email: true

  mount_uploader :icon, UserIconUploader

  has_many :reviews

  has_many :book_shelf_relations
  has_many :books, through: :book_shelf_relations

  has_many :review_favorites
  has_many :reviews, through: :review_favorites

  def generate_confirm_hash
    self.confirm_hash = SecureRandom.base64(20)
  end

  def email_confirm
    UserMailer.email_confirm(self).deliver_later
  end

  def is_favorite(review)
    if !instance_variable_defined?(:@favorite_list)
      @favorite_list = self.review_favorites
    end
  end

  def up_reliability(type)
    score = {
      tag_vote: 0.1,
      review: 0.5,
      edit_request: 0.5,
      review_favorite: 0.5
    }[type]
    self.reliability = score
    self.save!
  end

end
