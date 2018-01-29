# frozen_string_literal: true

create_table :stars, force: :cascade do |t|
  t.integer :book_id, null: false
  t.integer :point, null: false
  t.string :ip_address, null: false

  t.index [:ip_address, :book_id], unique: true
end

