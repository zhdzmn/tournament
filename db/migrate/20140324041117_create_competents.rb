class CreateCompetents < ActiveRecord::Migration
  def change
    create_table :competents do |t|
      t.string :name
      t.references :group

      t.timestamps
    end
  end
end
