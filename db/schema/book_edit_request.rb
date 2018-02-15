# frozen_string_literal: true

create_table :book_edit_requests, force: :cascade do |t|
  t.integer :book_id, null: false
  t.string :target_column, null: false
  t.string :action, null: false
  t.text :content, null: false

  t.datetime :created_at, null: false

end

