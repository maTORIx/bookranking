class StarsController < ApplicationController
  def create
    if cookies[:star_posted] == "true"
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404 and return
    end
    @book = Book.find(params[:book_id])
    star_params = {
      point: params[:point],
      ip_address: request.remote_ip
    }
    if !@book.stars.create!(star_params)
      head :forbidden
    end
    cookies[:star_posted] = {
      value: "true",
      path: "/books/#{@book.id}",
    }
  end
end
