class BookShelfRelation < ApplicationRecord
  belongs_to :book
  belongs_to :user

  after_create do
    @book = self.book
    @book.shelfed_length = @book.book_shelf_relations.length
    @book.save!
    end
end
