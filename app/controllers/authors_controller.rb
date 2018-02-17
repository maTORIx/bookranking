class AuthorsController < ApplicationController
  def create
    user_only
    @book = Book.find(params[:book_id])
    if @book != nil
      if !Author.create_request(@book, params[:author][:name])
        redirect_to @book, flash: {notifies: ["エラーが発生しました"]} and return
      end
    end
    redirect_to @book
  end
end
