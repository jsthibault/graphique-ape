require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get test_new_url
    assert_response :success
  end

  test "should get create" do
    get test_create_url
    assert_response :success
  end

end
