class Fixture < ActiveRecord::Base
  belongs_to :referee
  belongs_to :competent1, class_name: 'Competent'
  belongs_to :competent2, class_name: 'Competent'
  has_many :results, dependent: :destroy
  attr_accessible :match_date, :match_time, :match_begin, :competent1_id, :competent2_id, :referee_id, :stage

  validate :competents_and_stage_should_be_unique

  def to_s
    self.competent1.to_s + ' vs ' + self.competent2.to_s
  end

  def winner
    Competent.find(self.results.group_by(&:winner_id).map {|k, v| {k => v.length}}.sort_by {|s| s.values.first}.reverse.first.keys.first)
  end

  def loser
    Competent.find(self.results.group_by(&:winner_id).map {|k, v| {k => v.length}}.sort_by {|s| s.values.first}.first.keys.first)
  end
  
  private 
  def competents_and_stage_should_be_unique
    fixture1 = Fixture.where(competent1_id: competent1.id, competent2_id: competent2.id, stage: stage).first
    fixture2 = Fixture.where(competent2_id: competent1.id, competent1_id: competent2.id, stage: stage).first
    fixture1 = nil if self.id == fixture1.id
    fixture2 = nil if self.id == fixture2.id
    if fixture1.present? || fixture2.present?
      errors.add(:stage, "#{stage}, competents already played against each other")
    end
  end

end
