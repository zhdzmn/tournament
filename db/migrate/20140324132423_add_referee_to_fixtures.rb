class AddRefereeToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :referee_id, :integer
  end
end
