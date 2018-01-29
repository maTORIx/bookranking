class BookShelfController < ApplicationController
  before_action :user_only
  skip_before_action :user_only, only: [:index]

  def index
  end

  def create
    @user = User.find(params[:user_id])
    if @user == current_user
      @user.book_shelf_relations.create(book_id: params[:book_shelf_relation][:book_id])
    end
  end
end
