require 'test_helper'

class AwsControllerTest < ActionController::TestCase
  test "should get run_instance" do
    get :run_instance
    assert_response :success
  end

end
