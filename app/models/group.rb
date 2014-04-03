class Group < ActiveRecord::Base
  has_many :competents, order: "name"
  attr_accessible :mode, :name

  def to_s
    self.name
  end

  def to_opt_group
    self.mode + ' ' + self.name
  end

  def fixtures
    fxs = []
    self.competents.each do |c|
      fxs += c.home_fixtures
      fxs += c.away_fixtures
    end
    fxs.uniq {|f| f.id}
  end

end
