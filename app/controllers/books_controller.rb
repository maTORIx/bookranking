class BooksController < ApplicationController
  
  before_action :user_only
  skip_before_action :user_only, only: [:show]

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.page(1).per(10).includes(:user)
    @tag = Tag.new
    @book_shelf_relation = BookShelfRelation.new
  end

  def new
    user_only
    @book = Book.new
  end

  def create
    user_only
    book_params = params.require(:book).permit(:title, :description, :price, :pub_date, :cover_image)
    @book = Book.create(book_params)
    redirect_to @book
  end

  def edit
    user_only
    @book = Book.find(params[:id])
    @author = Author.new
    @category = Category.new
  end

  def update
    user_only
    @book = Book.find(params[:id])
    book_params = params.require(:book).permit(:title, :description, :price, :pub_date, :cover_image)
    @book.edit_request(book_params)
    redirect_to @book
  end

  def destroy
    user_only
    @book = Book.find(params[:id])
    @book.destroy
  end
end
