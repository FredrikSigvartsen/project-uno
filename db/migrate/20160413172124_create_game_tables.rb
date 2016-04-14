class CreateGameTables < ActiveRecord::Migration
  def change
    create_table :game_tables do |t|
      t.integer :game_id
      t.integer :card_id
      t.integer :user_id
      t.integer :card_in_deck
      t.integer :card_played
    end
  end
end
