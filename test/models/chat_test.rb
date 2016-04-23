require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  test "the truth" do
    chat = Chat.find(1)
    #chats.each do |chat|
      puts chat.to_s
      chat.save
      assert chat.save
      assert chat.destroy
    #end
  end
end
