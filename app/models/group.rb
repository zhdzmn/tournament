class Group < ActiveRecord::Base
  has_many :competents
  attr_accessible :mode, :name

  def to_s
    self.name
  end

end
