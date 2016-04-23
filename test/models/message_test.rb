require 'test_helper'

class MessageTest < ActiveSupport::TestCase
   test "the truth" do
     Message.find_each do |message|
      puts message.to_s
      assert message.save
      assert message.destroy
     end
   end
end
