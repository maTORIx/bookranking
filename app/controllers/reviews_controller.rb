class ReviewsController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
    @reviews = @book.reviews.page(params[:page]).per(20)
  end

  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.find_by(user_id: current_user.id)
    if @review != nil
      redirect_to action: "edit", id: @review.id
    end
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    review_params = params.require(:review).permit(:point, :body)
    review_params[:user_id] = current_user.id
    
    p review_params
    @review = @book.reviews.create(review_params)
  end

  def edit
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    p @review.has_permission?(current_user)
    if !@review.has_permission?(current_user)
      return render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def update
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    if !@review.has_permission?(current_user)
      return render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
    review_params = params.require(:review).permit(:point, :body)
    if (review_params[:point].to_i > 100) || (review_params[:point].to_i < 0)
      return render file: "#{Rails.root}/public/500.html", layout: false, status: 500
    end
    @review = @review.update(review_params)
    redirect_to @book
  end

end
