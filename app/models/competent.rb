class Competent < ActiveRecord::Base
  belongs_to :group
  has_many :fixtures
  has_many :results, foreign_key: :winner_id
  attr_accessible :group_id, :name

  def to_s
    self.name
  end

  def head_to_head(competent)
    fixture = Fixture.where('((competent1_id = (?) AND competent2_id = (?)) OR (competent2_id = (?) AND competent1_id = (?))) AND stage = "Group"', self.id, competent.id, self.id, competent.id)
    fixture.first
  end

end
