# frozen_string_literal: true

create_table :author_relations, force: :cascade do |t|
  t.integer :author_id, null: false
  t.integer :book_id, null: false

  t.index [:author_id, :book_id], unique: true

end

