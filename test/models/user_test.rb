require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_user
    fredrik = User.find(1)
    #fredrik.email = "feil@email.com"
    puts fredrik.to_s
    assert fredrik.save
    assert fredrik.destroy
  end
end
