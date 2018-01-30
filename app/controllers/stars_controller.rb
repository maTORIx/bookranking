class StarsController < ApplicationController
  def create
    if cookies[:star_posted] == "true"
      return render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
    @book = Book.find(params[:book_id])
    star_params = {
      point: params[:point],
      ip_address: request.remote_ip
    }
    begin
      @book.stars.create(star_params)
    rescue => e
      p e
      return render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
    cookies[:star_posted] = {
      value: "true",
      path: "/book/#{@book.id}",
    }
  end
end