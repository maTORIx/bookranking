class User < ApplicationRecord
  has_secure_password
  before_create :generate_confirm_hash
  
  validates :email, presence: true, uniqueness: true, email: true
  validates :name, uniqueness: true

  mount_uploader :icon, UserIconUploader

  has_many :reviews

  has_many :book_shelf_relations
  has_many :books, through: :book_shelf_relations

  def generate_confirm_hash
    self.confirm_hash = SecureRandom.base64(20)
  end

end
