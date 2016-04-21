require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_user
    User.find_each do |user|
      puts user.to_s
      assert user.save
      assert user.destroy
    end
  end
end
