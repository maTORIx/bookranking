class Star < ApplicationRecord
  belongs_to :book

  validates :ip_address, uniqueness: {scope: :book}

  after_create do
    @book = self.book
    @book.simple_point = @book.stars.average(:point).to_f
    @book.star_length = @book.stars.length
    @book.save!
  end
end
