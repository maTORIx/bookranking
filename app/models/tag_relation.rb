class TagRelation < ApplicationRecord
  belongs_to :tag
  belongs_to :book
  has_many :tag_votes

  scope :alive, -> {where(alive: true)}

  def vote(user, is_correct)
    vote = self.tag_votes.find_by(user_id: user.id, tag_relation_id: self.id)
    if vote == nil
      self.tag_votes.create!(is_correct: is_correct, user_id: user.id)
      return "created"
    else
      vote.update!(is_correct: is_correct)
      return "updated"
    end
  end

  def update_info
    tag_relation = self
    correct = self.tag_votes.where(is_correct: true).length
    discorrect = self.tag_votes.where(is_correct: false).length

    tag_relation.votes_length = correct + discorrect
    tag_relation.score = correct - discorrect
    tag_relation.alive = correct > discorrect
    tag_relation.corrects_length = correct

    tag_relation.save!
  end

  def self.update_info
    TagRelation.all.each {|tag| tag.update_info}
  end
end
