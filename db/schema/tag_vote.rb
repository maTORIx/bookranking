# frozen_string_literal: true

create_table :tag_votes, force: :cascade do |t|
  t.integer :tag_relation_id
  t.string :user_id
  t.boolean :is_correct

  t.index [:tag_relation_id, :user_id], unique: true

end

