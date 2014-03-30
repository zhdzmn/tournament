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
  
  private 
  def competents_and_stage_should_be_unique
    fixture1 = Fixture.where(competent1_id: competent1.id, competent2_id: competent2.id, stage: stage).first
    fixture2 = Fixture.where(competent2_id: competent1.id, competent1_id: competent2.id, stage: stage).first
    if fixture1.present? || fixture2.present?
      errors.add(:stage, "#{stage}, competents already played against each other")
    end
  end

end
