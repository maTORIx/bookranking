class AuthorsController < ApplicationController
  before_action :user_only

  def create
    @book = Book.find(params[:book_id])
    if @book != nil
      if !Author.create_request(@book, params[:author][:name], current_user)
        redirect_to @book, flash: {notifies: ["エラーが発生しました"]} and return
      end
    end
    redirect_to @book
  end

  def destroy
    @book = Book.find(params[:book_id])
    if @book != nil
      if Author.destroy_request(@book, params[:name], current_user) == nil
        redirect_to @book, flash: {notifies: ["エラーが発生しました"]} and return
      end
    end
    redirect_to @book
  end
end
