class AuthorsController < ApplicationController
  def create
    user_only
    @author = Author.find_or_create_by!(name: params[:author][:name])
    @book = Book.find(params[:book_id])
    if @book != nil
      @author.author_relations.find_or_create_by!({book_id: @book.id})
    end
    redirect_to @book
  end
end
