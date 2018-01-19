class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true, email: true

  mount_uploader :icon, UserIconUploader

  has_many :reviews

end
