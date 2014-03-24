class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :fixture
      t.references :winner
      t.integer :ball_in_table
      t.integer :match_number

      t.timestamps
    end
    add_index :results, :fixture_id
    add_index :results, :winner_id
  end
end
