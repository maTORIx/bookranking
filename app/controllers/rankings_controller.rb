class RankingsController < ApplicationController
  def index

    #order
    @order_param = :score
    if ["score", "all_review_point", "all_review_length", "review_point", "review_length", "shelfed_length", "pub_date", "tag_score"].include?(params[:order_param])
      @order_param = params[:order_param].to_sym
    end 

    @order = "desc"
    if ["asc"].include?(params[:order])
      @order = params[:order]
    end

    #find_books
    if params[:tags] == nil && params[:authors] == nil && params[:categories] == nil
      if [:tag_score].include? @order_param
        @order_param = :score
      end
      @books = Book.order(@order_param => @order).page(params[:page]).per(20).includes(:tags, :authors, :categories)
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

      if @order_param == :tag_score
        @books = Book.where(id: result[:book_ids]).order(['field(id, ?)', result[:book_ids]]).page(params[:page]).per(20).includes(:tag_relations, :authors, :categories)
      else
        @books = Book.where(id: result[:book_ids]).order(@order_param => @order).page(params[:page]).per(20).includes(:tag_relations, :authors, :categories)
      end

      
    end
  end
end
