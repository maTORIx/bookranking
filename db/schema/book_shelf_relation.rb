# frozen_string_literal: true

create_table :book_shelf_relations, force: :cascade do |t|
  t.integer :user_id
  t.integer :book_id

  t.index [:user_id, :book_id], unique: true
end

