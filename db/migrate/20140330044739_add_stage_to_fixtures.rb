class AddStageToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :stage, :string, default: 'Group', null: false
  end
end
