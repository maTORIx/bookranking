# frozen_string_literal: true

create_table :users, force: :cascade do |t|
  t.string :name
  t.string :email
  t.string :password_digest
  t.string :icon

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false

  t.index [:email], unique: true
end

