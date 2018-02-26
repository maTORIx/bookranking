# frozen_string_literal: true

create_table :tag_relations, force: :cascade do |t|
  t.integer :tag_id, null: false
  t.string :tag_name, null: false, default: ""
  t.integer :book_id, null: false
  t.integer :votes_length, null: false, default: 0
  t.integer :corrects_length, null: false, default: 0
  t.integer :score, null: false, default: 0
  t.boolean :alive, null: false, default: true

  t.index [:tag_id, :book_id], unique: true
end

