class StarsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    star_params = {
      book_id: @book.id,
      point: params[:point],
      ip_address: request.remote_ip
    }
    p star_params
    redirect_to @book
    end
end
