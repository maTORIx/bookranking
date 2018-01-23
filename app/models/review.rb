class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def has_permission?(user)
    user.id == self.user_id
  end
end
