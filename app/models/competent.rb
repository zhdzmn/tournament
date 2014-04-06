class Competent < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :home_fixtures, foreign_key: :competent1_id, class_name: 'Fixture'
  has_many :away_fixtures, foreign_key: :competent2_id, class_name: 'Fixture'
  has_many :results, foreign_key: :winner_id
  attr_accessible :group_ids, :name

  def to_s
    self.name
  end

  def head_to_head(competent)
    Fixture.where(competent1_id: self.id, competent2_id: competent.id, stage: 'Group').first || Fixture.where(competent1_id: competent.id, competent2_id: self.id, stage: 'Group').first
  end

end
