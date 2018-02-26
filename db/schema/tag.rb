# frozen_string_literal: true

create_table :tags, force: :cascade do |t|
  t.string :name, null: false
  t.integer :votes_length, default: 0
  t.integer :books_length, default: 0

  t.index [:name], unique: true
end

