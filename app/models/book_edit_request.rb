class BookEditRequest < ApplicationRecord
  validates :book_id, uniqueness: { scope: [:action, :content, :target_column] }

  belongs_to book

end
