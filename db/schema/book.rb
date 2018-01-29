# frozen_string_literal: true

create_table :books, force: :cascade do |t|

  t.string :title, null: false
  t.text :description, null: false
  t.integer :price, null: true
  t.date :pub_date, null: false, default: "2018-01-01"
  t.string :cover_image, null: true

  t.float :simple_point, null: true, default: 0
  t.float :review_point, null: true, default: 0

  t.integer :review_length
  t.integer :star_length
  t.integer :shelfed_length

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false

  t.index [:title, :pub_date], unique: true
end

