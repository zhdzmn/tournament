class Result < ActiveRecord::Base
  belongs_to :fixture
  belongs_to :winner, class_name: 'Competent'
  attr_accessible :ball_in_table, :match_number, :fixture_id, :winner_id
  after_save :save_fixture

  private
  def save_fixture
    self.fixture.save!
  end

end
