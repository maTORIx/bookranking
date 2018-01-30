class RankingsController < ApplicationController
  def index
    if params[:tags] == nil && params[:authors] == nil
      @books = Book.order(review_point: "desc").page(params[:page]).per(20)
    else
      books_id_from_tag = params[:tags] == nil ? [] : Tag.find_books_id(params[:tags].split("+"))
      books_id_from_author = params[:author] == nil ? [] : Author.find_books_id(params[:authors].split("+"))
      @books = Book.where(id: (books_id_from_tag + books_id_from_authori).uniq).order(review_point: "desc")
    end
  end
end
