# frozen_string_literal: true

create_table :tag_votes, force: :cascade do |t|
  t.integer :tag_relation_id, null: false
  t.string :user_id, null: false
  t.boolean :is_correct, null: false

  t.index [:tag_relation_id, :user_id], unique: true

end

