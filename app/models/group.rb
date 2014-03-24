class Group < ActiveRecord::Base
  attr_accessible :mode, :name

  def to_s
    self.name
  end

end
