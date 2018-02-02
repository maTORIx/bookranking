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

      if params[:tags] != nil
        books_id = Tag.find_books_id(params[:tags].split("+"))
      end

      if params[:authors] != nil
        ids = Author.find_books_id(params[:authors].split("+"))
        if books_id == []
          books_id = ids
        else
          books_id = books_id & ids
        end
      end

      if params[:category]
        ids = Category.find_books_id(params[:category].split("+"))
        if books_id == []
          books_id = ids
        else 
          books_id = books_id & ids
        end
      end

      @books = Book.where(id: books_id.uniq).order(order_param => order).page(params[:page]).per(20)
    end
  end
end
