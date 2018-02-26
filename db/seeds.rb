# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def dic2book(book)
  if book == nil
    {}
  end
  {
    id: book["id"],
    title: book["volumeInfo"]["title"],
    pub_date: book["volumeInfo"]["publishedDate"],
    categories: book["volumeInfo"]["categories"],
    authors: book["volumeInfo"]["authors"],
    page_count: book["pageCount"],
    description: book["volumeInfo"]["description"].to_s,
    language: book["volumeInfo"]["language"],
    print_type: book["volumeInfo"]["printType"]
  }
end

def search_books(question, index=1)
  resp = open("https://www.googleapis.com/books/v1/volumes?q=#{URI.encode(question)}&maxResults=40&startIndex=#{index}&orderBy=newest").read
  data = JSON.parse(resp)
  p data["items"].length
  data["items"].map {|book| dic2book(book)}
end

items = search_books(('あ'..'を').to_a[rand(26)])

#items = search_books("金持ち父さん", 8)

items.each do |book|
  p book
  if book[:pub_date] == nil
    book[:pub_date] == nil
  elsif book[:pub_date].length == 7
    book[:pub_date] = Date.parse(book[:pub_date] + "-01")
  elsif book[:pub_date].length == 4
    book[:pub_date] = Date.parse(book[:pub_date] + "-01-01")
  else
    book[:pub_date] = Date.parse(book[:pub_date])
  end

  @book = Book.new(title: book[:title], description: book[:description], price: nil, pub_date: book[:pub_date])
  if book[:id] != nil
    p book[:id]
    resp = open("https://books.google.com/books/content/images/frontcover/" + book[:id].to_s + "?fife=w1000-h1000")
    p resp.status
    if resp != nil
      @book.cover_image = resp
    end
  end
  if @book.save

    if book[:authors] != nil
      book[:authors].each do |author|
        @book.add_author(author)
      end
    end
    if book[:categories] != nil
      book[:categories].each do |category|
        @book.add_category(category)
      end
    end

    if book[:print_type] != nil
      types = {
        BOOK: "本",
        MAGAZINE: "漫画"
      }
      type = types[book[:print_type].to_sym]
      @book.add_category(type)
    end
  end
end

