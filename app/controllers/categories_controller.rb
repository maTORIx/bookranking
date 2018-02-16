class CategoriesController < ApplicationController
  def create
    user_only
    @book = Book.find(params[:book_id])
    if @book != nil
      @book.categories.create_request({name: params[:category][:name]})
    end
    redirect_to @book
  end
end
