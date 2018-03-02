# frozen_string_literal: true

create_table :review_favorites, force: :cascade do |t|

  t.integer :user_id, null: false
  t.integer :review_id, null: false

  t.datetime :created_at, null: false

  t.index [:user_id, :review_id], unique: true
end

