class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :game_id
      t.integer :message_id

      t.timestamps null: false
    end
  end
end
