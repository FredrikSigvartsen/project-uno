class CreateGameTables < ActiveRecord::Migration
  def change
    create_table :game_tables do |t|
      t.integer :game_id
      t.integer :card_id
      t.integer :user_id
      t.boolean :card_in_deck
      t.boolean :card_played

      t.timestamps null: false
    end
  end
end
