class AddMatchBeginToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :matchBegin, :boolean
  end
end
