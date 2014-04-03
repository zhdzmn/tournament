class AddModeAndGroupToFixture < ActiveRecord::Migration
  def change
    add_column :fixtures, :mode, :string
  end
end
