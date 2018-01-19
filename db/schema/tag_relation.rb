# frozen_string_literal: true

create_table :tag_relations, force: :cascade do |t|
  t.integer :tag_id, null: false
  t.integer :book_id, null: false

  t.index [:tag_id, :book_id], unique: true
end

