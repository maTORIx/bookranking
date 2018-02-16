class BookEditRequest < ApplicationRecord
  validates :book_id, uniqueness: { scope: [:action, :content, :target_column] }

  belongs_to :book
  
  def accept
    @book = self.book
    if self.action == "edit"
      @book.update!(self.target_column.to_sym => self.content)
    elsif self.action == "create"

      content = @book.send(self.target_column + "s").find_or_create_by!(self.content)
      symb = (self.target_column + "_id").to_sym
      @book.send(self.target_column + "_relations").create!(symb => content.id)

    elsif self.action == "destroy"

      content = @book.send(self.target_column + "s").find_by(name: self.content)
      symb = (self.target_column + "_id").to_sym
      @book.send(self.target_column + "_relations").find_by(symb => content.id).destroy
    end
  end

end
