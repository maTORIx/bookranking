# frozen_string_literal: true

create_table :reviews, force: :cascade do |t|
  t.integer :book_id, null: false
  t.integer :user_id, null: false
  t.integer :point, null: false
  t.string :title, null: true
  t.text :body, null: false

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false

  t.index [:book_id, :user_id], unique: true
end

