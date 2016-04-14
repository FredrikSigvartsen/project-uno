class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :message_id
      t.string :game_id
    end
  end
end
