# frozen_string_literal: true

create_table :reviews, force: :cascade do |t|
  t.integer :book_id, null: false
  t.integer :user_id, null: false
  t.integer :point, null: false
  t.string :title, null: false
  t.text :body, null: true
  t.integer :favorites_count, default: 0, null: false

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false

  t.index [:book_id, :user_id], unique: true
end

