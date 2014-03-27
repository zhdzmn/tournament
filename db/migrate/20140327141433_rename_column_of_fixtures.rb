class RenameColumnOfFixtures < ActiveRecord::Migration
  def change
    rename_column :fixtures, :matchDate, :match_date
    rename_column :fixtures, :matchTime, :match_time
    rename_column :fixtures, :matchBegin, :match_begin
  end
end
