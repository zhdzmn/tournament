class AddSecondRoundToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :second_round, :boolean, default: false
  end
end
