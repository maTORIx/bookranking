class RequestsController < ApplicationController
  before_action :admin_only

  def admin_only
    if current_user.admin == false
      redirect_to "/"
    end
  end

  def index
    @book_edit_requests = BookEditRequest.order(created_at: "asc").page(params[:page]).per(10)
  end

  def show
    @book_edit_request = BookEditRequest.find(params[:id])
  end

  def update
    @book_edit_request = BookEditRequest.find(params[:id])
    @book_edit_request.accept
    redirect_to action: "index"
  end


  def destroy
    @book_edit_request = BookEditRequest.find(params[:id])
    @book_edit_request.destroy
    redirect_to action: "index"
  end
end
