require 'test_helper'

class RunnersControllerTest < ActionController::TestCase
  setup do
    @runner = runners(:one)
  end

  test "should show runner" do
    get 'sessions#login'
    assert_response :success
  end

end