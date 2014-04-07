class Competent < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :home_fixtures, foreign_key: :competent1_id, class_name: 'Fixture'
  has_many :away_fixtures, foreign_key: :competent2_id, class_name: 'Fixture'
  has_many :results, foreign_key: :winner_id
  attr_accessible :group_ids, :name

  validate :one_group_from_each_round_can_be_assiciated
  validate :max_two_groups

  def to_s
    self.name
  end

  def head_to_head(competent)
    Fixture.where(competent1_id: self.id, competent2_id: competent.id, stage: 'Group').first || Fixture.where(competent1_id: competent.id, competent2_id: self.id, stage: 'Group').first
  end

  private
  def one_group_from_each_round_can_be_assiciated
    if self.groups.size > 1
      group1 = self.groups.first
      group2 = self.groups[1]

      unless group1.mode == group2.mode
        errors.add(:groups, " has to be of the same mode")
      end
      if group1.second_round == group2.second_round
        errors.add(:groups, " has to be of two different rounds")
      end
    end
  end
  def max_two_groups
    if self.groups.size > 2
      errors.add(:groups, " can be only of maximum 2")
    end
  end

end
