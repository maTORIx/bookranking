class BookShelfRelation < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book, uniqueness: { scope: :user }

  after_create :realize_length

  def realize_length
    @book = self.book
    @book.shelfed_length = @book.book_shelf_relations.length
    @book.save
  end
end
