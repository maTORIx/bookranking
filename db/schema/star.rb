# frozen_string_literal: true

create_table :stars, force: :cascade do |t|
  t.integer :book_id, null: false
  t.integer :point, null: false
  t.string :ip_address, null: false

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false

  t.index [:ip_address], unique: true
end

