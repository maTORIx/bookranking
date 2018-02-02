class RankingsController < ApplicationController
  def index

    order_param = :review_point
    if ["simple_point", "review_length", "star_length", "shelfed_length", "pub_date"].include?(params[:order_param])
      order_param = params[:order_param].to_sym
    end 

    order = "desc"
    if ["asc"].include?(params[:order])
      order = params[:order]
    end

    if params[:tags] == nil && params[:authors] == nil && params[:category] == nil
      @books = Book.order(order_param => order).page(params[:page]).per(20)
    else
      books_id = []
      books_id = params[:tags] == nil ? books_id : Tag.find_books_id(params[:tags].split("+"))

      books_id_from_author = params[:authors] == nil ? books_id : Author.find_books_id(params[:authors].split("+"))
      books_id = books_id == [] ? books_id_from_author : books_id & books_id_from_author

      books_id_from_category = params[:category] == nil ? books_id : Category.find_books_id(params[:category].split("+"))
      books_id = books_id == [] ? books_id_from_category : books_id & books_id_from_category

      @books = Book.where(id: books_id.uniq).order(order_param => order)
    end
  end
end
