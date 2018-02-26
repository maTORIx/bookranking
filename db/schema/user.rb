# frozen_string_literal: true

create_table :users, force: :cascade do |t|
  t.string :name, null:false
  t.string :email, null: false
  t.string :password_digest, null: false
  t.string :icon, null: true
  t.boolean :confirmed, default: false, null: false
  t.string :confirm_hash, default: "123456", null: false
  t.boolean :admin, default: 0

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false

  t.index [:email], unique: true
end

