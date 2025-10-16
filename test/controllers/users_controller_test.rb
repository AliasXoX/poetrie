require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:spiderman)
  end

  test "should redirect index when not logged in" do
    get users_url
    assert_redirected_to login_url
  end

  test "should get index when logged in" do
    log_in_as(@user)
    get users_url
    assert_response :success
  end

  test "should get new when logged in" do
    log_in_as(@user)
    get new_user_url
    assert_response :success
  end

  test "should create user when logged in and redirected to root path" do
    log_in_as(@user)
    assert_difference("User.count") do
      post users_url, params: { user: { username: "newuser", password: "password" } }
    end
    assert_redirected_to root_path
  end
end
