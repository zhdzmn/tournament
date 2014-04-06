class Fixture < ActiveRecord::Base
  belongs_to :referee
  belongs_to :group
  belongs_to :competent1, class_name: 'Competent'
  belongs_to :competent2, class_name: 'Competent'
  has_many :results, dependent: :destroy
  attr_accessible :match_date, :match_time, :match_begin, :competent1_id, :competent2_id, :referee_id, :stage, :mode, :group_id

  validate :competents_and_stage_should_be_unique
  validate :competents_should_be_on_same_group_if_group_stage
  validate :competents_should_be_on_same_mode
  validate :competents_should_be_different
  validate :group_has_to_be_set_if_group_stage
  
  validates :competent1_id, :competent2_id, presence: true

  before_save :populate_mode
  before_save :populate_match_began

  def to_s
    self.competent1.to_s + ' vs ' + self.competent2.to_s
  end

  def winner
    id_win_array = self.results.group_by(&:winner_id).map {|k, v| {k => v.length}}.sort_by {|s| s.values.first}.reverse.first
    if id_win_array.present?
      Competent.find(id_win_array.keys.first)
    else
      nil
    end
  end

  def loser
    winner_competent = self.winner
    if self.competent1.id == winner_competent.try(:id)
      self.competent2
    elsif self.competent2.id == winner_competent.try(:id)
      self.competent1
    end
  end

  def new_result_creatable?
    if stage == 'Group'
      self.results.count < 3
    else
      self.results.count < 5
    end
  end
  
  private
  def competents_and_stage_should_be_unique
    fixture1 = Fixture.where(competent1_id: competent1.id, competent2_id: competent2.id, stage: stage).first
    fixture2 = Fixture.where(competent2_id: competent1.id, competent1_id: competent2.id, stage: stage).first
    fixture1 = nil if self.try(:id) == fixture1.try(:id)
    fixture2 = nil if self.try(:id) == fixture2.try(:id)
    if fixture1.present? || fixture2.present?
      errors.add(:stage, "#{stage}, competents already played against each other")
    end
  end
  def competents_should_be_on_same_group_if_group_stage
    if stage == 'Group'
      unless self.competent1.groups.exists?(self.group_id) && self.competent2.groups.exists?(self.group_id)
        errors.add(:group_id, " competents should be in #{group}")
      end
    end
  end
  def competents_should_be_on_same_mode
    if competent1.groups.first.try(:mode) != competent2.groups.first.try(:mode)
      errors.add(:competent1, "competents should be in the same mode")
    end
  end
  def populate_mode
    self.mode = competent1.groups.first.try(:mode)
  end
  def populate_match_began
    if self.new_record?
      self.match_begin = 0
    else 
      if self.results.size == 0
        self.match_begin = 0
      end
      self.match_begin = 1
    end
  end
  def competents_should_be_different
    if competent1.id == competent2.id
      errors.add(:competent1, " and competent2 should be different")
    end
  end
  def group_has_to_be_set_if_group_stage
    if self.stage == 'Group'
      if self.group.blank?
        errors.add(:group, " needs to be set on group stage")
      end
    end
  end

end
