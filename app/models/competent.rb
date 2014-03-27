class Competent < ActiveRecord::Base
  belongs_to :group
  has_many :fixtures
  has_many :results, foreign_key: :winner_id
  attr_accessible :group_id, :name

  def to_s
    self.name
  end

end
