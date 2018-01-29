# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def get_books(idx = 1)
  def to_info(book)
    pub_date = book["pubDate"]

    if pub_date == nil || pub_date == "nil"
      pub_date = Date.parse("2000-01-01")
    else
      pub_date = Date.parse(pub_date)
    end

    authors = book["creator"]
    if !authors.kind_of?(Array)
      authors = authors == nil ? [] : [authors]
    end
    authors = authors.map {|author| author.gsub(/,| ?[ 　,\/].*$/, "")}
  
    {title: book["title"][0], description: book["description"].to_s.gsub(/<\/?..?>/,""), author: authors, pub_date: pub_date, publisher: book["publisher"], link: book["link"]}
  end
  
  category = 1
  idx = idx 
  from = "2017-01-01"
  
  xml = open("http://iss.ndl.go.jp/api/opensearch?ndc=#{category}&idx=#{idx}&from=#{from}").read
  json = Hash.from_xml(xml).to_json
  
  src = JSON.parse(json)
  items = src["rss"]["channel"]["item"]
  items = items.map{|book| to_info book}
  
  items
end

items = get_books
items.each do |book|
  begin
    @book = Book.create(title: book[:title], description: book[:description], price: nil, pub_date: book[:pub_date])
    book[:author].each do |author|
      @book.add_author(author)
    end
  rescue
    p "error"
  end
end

