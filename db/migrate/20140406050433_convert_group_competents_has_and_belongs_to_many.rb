class ConvertGroupCompetentsHasAndBelongsToMany < ActiveRecord::Migration
  def up
    competents = Competent.all
    competents.each do |c|
      g = Group.find(c.group_id)
      c.groups = [g]
      c.save!
    end
    remove_column(:competents, :group_id)
  end

  def down
    add_column(:competents, :group_id, :integer)
  end
end
