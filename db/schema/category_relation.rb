# frozen_string_literal: true

create_table :category_relations, force: :cascade do |t|
  t.integer :book_id, null: false
  t.integer :category_id, null: false

  t.index [:book_id, :category_id], unique: true
end

