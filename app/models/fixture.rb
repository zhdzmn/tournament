class Fixture < ActiveRecord::Base
  belongs_to :referee
  belongs_to :competent1, class_name: 'Competent'
  belongs_to :competent2, class_name: 'Competent'
  has_many :results
  attr_accessible :matchDate, :matchTime, :matchBegin, :competent1_id, :competent2_id, :referee_id

  def to_s
    self.competent1.to_s + ' vs ' + self.competent2.to_s
  end

end
