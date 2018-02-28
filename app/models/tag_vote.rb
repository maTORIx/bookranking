class TagVote < ApplicationRecord
  validates :user_id, uniqueness: {scope: :tag_relation_id}
  belongs_to :tag_relation
  belongs_to :user
  delegate :tag, to: :tag_relation
  after_save do
    self.tag_relation.update_info
  end

  after_create do
    user = self.user
    user.reliability += 0.1
    user.save!
  end
end
