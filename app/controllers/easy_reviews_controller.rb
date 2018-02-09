class EasyReviewsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    if cookies[:easy_review_posted] == "true"
      head :forbidden
    end
    review_params = {
      point: params[:point],
      ip_address: request.remote_ip
    }
    if !@book.easy_reviews.create(review_params)
      head :forbidden
    end
    cookies[:easy_review_posted] = {
      value: "true",
      path: "/books/#{@book.id}",
    }
  end
end
