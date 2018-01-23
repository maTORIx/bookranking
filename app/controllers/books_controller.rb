class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.page(1).per(10)
  end

  def new
    @book = Book.new
  end

  def create
    book_params = params.require(:book).permit(:title, :description, :price, :releace_date, :cover_image)
    @book = Book.create(book_params)
    redirect_to @book
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    book_params = params.require(:book).permit(:title, :description, :price, :releace_date, :cover_image)
    @book.update(book_params)
    redirect_to @book
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end
end
