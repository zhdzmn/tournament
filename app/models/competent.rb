class Competent < ActiveRecord::Base
  belongs_to :group
  attr_accessible :group_id, :name

  def to_s
    self.name
  end

end
