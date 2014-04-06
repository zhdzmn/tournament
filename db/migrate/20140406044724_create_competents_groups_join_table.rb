class CreateCompetentsGroupsJoinTable < ActiveRecord::Migration
  def change
    create_table :competents_groups, id: false do |t|
      t.integer :competent_id
      t.integer :group_id
    end
    add_index :competents_groups, [:competent_id, :group_id]
  end
end
