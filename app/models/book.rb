class Book < ApplicationRecord
  mount_uploader :cover_image, BookCoverUploader

  validates :title, uniqueness: {scope: [:pub_date, :description]}

  has_many :reviews

  has_many :author_relations
  has_many :authors , through: :author_relations
  
  has_many :tag_relations
  has_many :tags, through: :tag_relations

  scope :alive_tag_relations, -> {tag_relations.where(alive: true)}
  has_many :alive_tags, through: :alive_tag_relations

  has_many :category_relations
  has_many :categories, through: :category_relations

  has_many :easy_reviews

  has_many :book_shelf_relations

  has_many :book_edit_requests

  def add_author(name)
    author = Author.find_or_create_by!(name: name)
    self.author_relations.create(author_id: author.id)
  end

  def add_category(name)
    category = Category.find_or_create_by!(name: name)
    self.category_relations.create(category_id: category.id)
  end

  def tags_score(tags)
    self.tag_relations.where(tag_name: tags).sum(:score)
  end


  def self.classifiers
    {
      all_review_point: "点",
      review_point: "点",
      all_review_length: "件",
      review_length: "件",
      shelfed_length: "件"
    }
  end

  def self.column_japanese_names
    {
      score: "総合得点",
      all_review_point: "総レビュー評価",
      review_point: "レビュー評価",
      all_review_length: "総レビュー件数",
      shelfed_length: "本棚に入れた数"
    }
  end

  def generate_all_review_point
    (self.easy_review_length * self.easy_review_point + (self.review_length * 2) * self.review_point) / (self.easy_review_length + (self.review_length * 2))
  end

  def generate_score
    self.all_review_point * 20
  end

  def update_info
    @book = self
    @book.easy_review_length = @book.easy_reviews.length
    if @book.easy_review_length > 0
      @book.easy_review_point = @book.easy_reviews.average(:point).floor(3).to_f
    end

    @book.review_length = @book.reviews.length
    if @book.review_length > 0
      @book.review_point = @book.reviews.average(:point).floor(3).to_f
    end

    @book.all_review_length = @book.easy_review_length + @book.review_length
    if @book.all_review_length > 0
      @book.all_review_point = @book.generate_all_review_point.floor(3).to_f
      @book.score = @book.generate_score
    end

    @book.save!
  end

  def self.update_info!
    Book.all.each {|book| book.update_info}
    end

  def edit_request(params)
    for key in params
      if Book.column_names.include?(key) && self[key.to_sym].to_s != params[key.to_sym]
        self.book_edit_requests.create(target_column: key.to_s, action: "update", content: params[key.to_sym])
      end
    end
  end


  def self.ranking(params)

    @order_param = :score
    if ["score", "all_review_point", "all_review_length", "review_point", "review_length", "shelfed_length", "pub_date"].include?(params[:order_param])
      @order_param = params[:order_param].to_sym
    end 

    @order = "desc"
    if ["asc"].include?(params[:order])
      @order = params[:order]
    end

    #find_books
    if params[:tags] == nil && params[:authors] == nil && params[:category] == nil
      Book.order(@order_param => @order).page(params[:page]).per(20).includes(:tags, :authors, :categories)
    else

      result = {
        book_ids: [],
        empty: true
      }

      if params[:tags] != nil
        result[:book_ids] = Tag.find_books_id(params[:tags].split(" "))
        result[:empty] = false
      end

      if params[:authors] != nil
        ids = Author.find_books_id(params[:authors].split(" "))
        result[:book_ids] = result[:empty] ? ids : result[:book_ids] & ids
        result[:empty] = false
      end

      if params[:categories]
        ids = Category.find_books_id(params[:categories].split(" "))
        result[:book_ids] = result[:empty] ? ids : result[:book_ids] & ids
        result[:empty] = false
      end

      Book.where(id: result[:book_ids]).order(@order_param => @order).page(params[:page]).per(20).includes(:tags, :authors, :categories)
    end
  end

end
