# frozen_string_literal: true

create_table :easy_reviews, force: :cascade do |t|
  t.integer :book_id
  t.integer :point
  t.string :ip_address

  t.datetime :created_at, null: false

  t.index [:ip_address, :book_id], unique: true
end

