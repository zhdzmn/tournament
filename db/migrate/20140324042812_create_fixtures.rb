class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.references :competent1
      t.references :competent2
      t.date :matchDate
      t.time :matchTime

      t.timestamps
    end
    add_index :fixtures, :competent1_id
    add_index :fixtures, :competent2_id
  end
end
