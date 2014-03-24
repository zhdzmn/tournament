class Result < ActiveRecord::Base
  belongs_to :fixture
  belongs_to :winner, class_name: 'Competent'
  attr_accessible :ball_in_table, :match_number, :fixture_id, :winner_id
end
