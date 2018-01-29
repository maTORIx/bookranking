class TagsController < ApplicationController
  before_action :user_only

  def create
    @tag = Tag.find_or_create_by!(name: params[:tag][:name])
    @book = Book.find(params[:book_id])
    if @book != nil
      @tag_relation = @tag.tag_relations.find_or_create_by!({book_id: @book.id})
    end
    redirect_to @book
  end
end
