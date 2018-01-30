class RankingsController < ApplicationController
  def index
    @books = Book.order(review_point: "desc").page(params[:page]).per(20)
  end
end
