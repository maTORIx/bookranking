# frozen_string_literal: true

create_table :tag_relations, force: :cascade do |t|
  t.integer :tag_id, null: false
  t.integer :book_id, null: false
  t.integer :votes_length, null: false, default: 0
  t.integer :corrects, null: false, default: 0

  t.index [:tag_id, :book_id], unique: true
end

