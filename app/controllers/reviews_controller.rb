class ReviewsController < ApplicationController
  
  before_action :user_only
  skip_before_action :user_only, only: [:index]
  
  def index
    @book = Book.find(params[:book_id])
    @reviews = @book.reviews.page(params[:page]).per(20)
  end

  def show
    @review = Review.find(params[:id])
    @book = @review.book
  end

  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.find_by(user_id: current_user.id)
    if @review != nil
      return redirect_to action: "edit", id: @review.id
    end
    @review = Review.new
    
  end

  def create
    @book = Book.find(params[:book_id])
    review_params = params.require(:review).permit(:point, :body, :title)
    review_params[:user_id] = current_user.id
    if @book.reviews.create(review_params)
      redirect_to action: :new and return
    end
    redirect_to @book and return
  end

  def edit
    @review = Review.find(params[:id])
    if !@review.has_permission?(current_user)
      return render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def update
    @review = Review.find(params[:id])
    if !@review.has_permission?(current_user)
    end
    review_params = params.require(:review).permit(:point, :body, :title)
    if !@review.update(review_params)
      redirect_to action: "edit", notifies: ["エラーが発生しました"] and return
    end
    redirect_to @review and return
  end

end
