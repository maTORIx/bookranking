# frozen_string_literal: true

create_table :users, force: :cascade do |t|
  t.string :name, null:false
  t.string :email, null: false
  t.string :password_digest, null: false
  t.string :icon, null: true

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false

  t.index [:email], unique: true
  t.index [:name], unique: true
end

