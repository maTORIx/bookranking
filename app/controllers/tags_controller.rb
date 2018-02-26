class TagsController < ApplicationController
  before_action :user_only

  def index
    @tags = Tag.page(params[:page]).order(votes_length: "desc").includes(:tag_relations)
  end

  def create
    @tag = Tag.find_or_create_by!(name: params[:tag][:name])
    @book = Book.find(params[:book_id])
    if @book != nil
      @tag_relation = @tag.tag_relations.find_or_create_by!({book_id: @book.id, tag_name: params[:tag][:name]})
      @tag_relation.vote(current_user, true)
    end
    redirect_to @book
  end

  def update
    @tag = Tag.find_by(name: params[:name])
    @book = Book.find(params[:book_id])
    @tag_relation = TagRelation.find_by(book_id: @book.id, tag_id: @tag.id)
    status = @tag_relation.vote(current_user, params[:is_correct])
    if status == "created"
      redirect_to @book, flash: {notifies: ["投票しました"]}
    elsif status == "updated"
      redirect_to @book, flash: {notifies: ["再投票しました"]}
    else
      redirect_to @book, flash: {notifies: ["エラーが発生しました"]}
    end
  end
end
