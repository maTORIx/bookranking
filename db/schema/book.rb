# frozen_string_literal: true

create_table :books, force: :cascade do |t|

  t.string :title, null: false
  t.text :description, null: false
  t.integer :price, null: false
  t.datetime :release_date, null: true
  t.string :cover_image, null: true

  t.float :simple_point, null: true
  t.float :review_point, null: true

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false

  t.index [:title, :price], unique: true
end

