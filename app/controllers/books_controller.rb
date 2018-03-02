class BooksController < ApplicationController
  
  before_action :user_only
  skip_before_action :user_only, only: [:show]

  def show
    @book = Book.includes(:tag_relations, :authors, :categories).find(params[:id])
    @reviews = Review.where(book_id: params[:id]).limit(10).includes(:user)
    @tag = Tag.new
    @book_shelf_relation = BookShelfRelation.new
    @tag_chart = @book.tag_relations.alive.map {|tag| [tag.tag_name, tag.score]}
  end

  def new
    @book = Book.new
  end

  def create
    book_params = params.require(:book).permit(:title, :description, :price, :pub_date, :cover_image)
    @book = Book.create(book_params)
    redirect_to @book
  end

  def edit
    @book = Book.find(params[:id])
    @author = Author.new
    @category = Category.new
  end

  def update
    @book = Book.find(params[:id])
    book_params = params.require(:book).permit(:title, :description, :price, :pub_date, :cover_image)
    @book.edit_request(book_params, current_user)
    redirect_to @book, flash: {notifies: ["リクエストを送信しました"]}
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end
end
