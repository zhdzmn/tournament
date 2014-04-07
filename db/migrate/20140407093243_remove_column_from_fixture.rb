class RemoveColumnFromFixture < ActiveRecord::Migration
  def up
    remove_column :fixtures, :group_id
  end

  def down
    add_column :fixtures, :group_id, :integer
  end
end
