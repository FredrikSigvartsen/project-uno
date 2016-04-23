class RemoveMessageIdToChats < ActiveRecord::Migration
  def change
    remove_column :chats, :message_id, :string
  end
end
