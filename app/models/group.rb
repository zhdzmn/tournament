class Group < ActiveRecord::Base
  has_and_belongs_to_many :competents, order: "name"
  has_many :fixtures
  has_many :results, through: :fixtures
  attr_accessible :mode, :name

  def to_s
    self.name
  end

  def to_opt_group
    self.mode + ' ' + self.name
  end
end
