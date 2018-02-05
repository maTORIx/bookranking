class RankingsController < ApplicationController
  def index


    #order
    order_param = :review_point
    if ["simple_point", "review_length", "star_length", "shelfed_length", "pub_date"].include?(params[:order_param])
      order_param = params[:order_param].to_sym
    end 

    order = "desc"
    if ["asc"].include?(params[:order])
      order = params[:order]
    end

    #find_books
    if params[:tags] == nil && params[:authors] == nil && params[:category] == nil
      @books = Book.order(order_param => order).page(params[:page]).per(20).includes(:tags, :authors, :categories)

    else

      result = {
        book_ids: [],
        empty: true
      }

      if params[:tags] != nil
        result[:book_ids] = Tag.find_books_id(params[:tags].split(" "))
        result[:empty] = false
      end

      if params[:authors] != nil
        ids = Author.find_books_id(params[:authors].split(" "))
        result[:book_ids] = result[:empty] ? ids : result[:book_ids] & ids
        result[:empty] = false
      end

      if params[:categories]
        ids = Category.find_books_id(params[:categories].split(" "))
        result[:book_ids] = result[:empty] ? ids : result[:book_ids] & ids
        result[:empty] = false
      end

      @books = Book.where(id: result[:book_ids]).order(order_param => order).page(params[:page]).per(20).includes(:tags, :authors, :categories)
      
    end
  end
end
