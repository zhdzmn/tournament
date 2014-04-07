class Group < ActiveRecord::Base
  has_and_belongs_to_many :competents, order: "name"
  attr_accessible :mode, :name, :second_round

  validates_uniqueness_of :name, scope: :mode
  validate :only_one_second_round_group

  def to_s
    self.name
  end

  def to_opt_group
    self.mode + ' ' + self.name
  end

  def fixtures
    fxs = []
    competents.each do |c1|
      competents.each do |c2|
        unless c1.id == c2.id
          fxs = fxs + c1.home_fixtures.where(competent2_id: c2.id, stage: 'Group')
          fxs = fxs + c2.home_fixtures.where(competent1_id: c1.id, stage: 'Group')
        end
      end
    end
    fxs
  end

  def results
    rs = []
    self.fixtures.each do |f|
      rs = rs + f.results
    end
    rs
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
