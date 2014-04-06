class AddGroupIdToFixtures < ActiveRecord::Migration
  def up
    add_column :fixtures, :group_id, :integer
    fixtures = Fixture.all
    fixtures.each do |f|
      f.group_id = f.competent1.groups.first.try(:id)
      f.save!
    end
  end
  def down
    remove_column :fixtures, :group_id
  end
end
