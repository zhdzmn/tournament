class Competent < ActiveRecord::Base
  belongs_to :group
  has_many :fixtures
  has_many :results, foreign_key: :winner_id
  attr_accessible :group_id, :name

  def to_s
    self.name
  end

  def head_to_head(competent)
    Fixture.where(competent1_id: self.id, competent2_id: competent.id, stage: 'Group').first || Fixture.where(competent1_id: competent.id, competent2_id: self.id, stage: 'Group').first
  end

end
