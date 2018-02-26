# frozen_string_literal: true

create_table :books, force: :cascade do |t|

  t.string :title, null: false
  t.text :description, null: false
  t.integer :price, null: true
  t.date :pub_date, null: true, default: "2018-01-01"
  t.string :cover_image, null: true

  t.float :score, null: false, default: 0
  t.float :simple_point, null: false, default: 0
  t.float :easy_review_point, null: false, default: 0
  t.float :review_point, null: false, default: 0
  t.float :all_review_point, null: false, default: 0

  t.integer :review_length, default: 0
  t.integer :star_length, default: 0
  t.integer :easy_review_length, default: 0
  t.integer :shelfed_length, default: 0
  t.integer :all_review_length, default: 0

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false

  t.index [:title, :pub_date], unique: true

end

