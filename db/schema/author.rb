# frozen_string_literal: true

create_table :authors, force: :cascade do |t|
  t.string :name, null: false

  t.index [:name], unique: true
end

