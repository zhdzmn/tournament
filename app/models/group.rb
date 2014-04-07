class Group < ActiveRecord::Base
  has_and_belongs_to_many :competents, order: "name"
  has_many :fixtures
  has_many :results, through: :fixtures
  attr_accessible :mode, :name, :second_round

  validates_uniqueness_of :name, scope: :mode
  validate :only_one_second_round_group

  def to_s
    self.name
  end

  def to_opt_group
    self.mode + ' ' + self.name
  end

  private
  def only_one_second_round_group
    g = Group.where({mode: self.mode, second_round: self.second_round})
    unless self.new_record?
      g = g.where(['id != ?', self.id])
    end
    if g.size > 0
      errors.add(:second_round, " can have only one group")
    end
  end
end
