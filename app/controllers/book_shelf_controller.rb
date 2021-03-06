class BookShelfController < ApplicationController
  before_action :user_only
  skip_before_action :user_only, only: [:index]

  def create
    @user = User.find(params[:user_id])
    if @user == current_user
      relation = @user.book_shelf_relations.create(book_id: params[:book_shelf_relation][:book_id])
      if !relation.persisted?
        render file: "#{Rails.root}/public/403.html", layout: false, status: 403
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if params[:user_id].to_i != current_user.id
      render file: "#{Rails.root}/public/403.html", layout: false, status: 403
    else
      @book_shelf_relation = current_user.book_shelf_relations.find_by(book_id: params[:book_id])
      if !@book_shelf_relation.destroy
        render file: "#{Rails.root}/public/403.html", layout: false, status: 500
      end
    end
    redirect_back(fallback_location: root_path)
  end
end
