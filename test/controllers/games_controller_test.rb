require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "should get newgame" do
    get :newgame
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
