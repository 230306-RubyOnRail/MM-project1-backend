require "./test/test_helper"
require "Authenticatable"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Authenticatable

  def setup
    @user = users(:one)
    @manager = users(:manager)
  end

  test "should get index when authenticated as manager" do
    login_as(@manager)
    get users_url
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should not get index when not authenticated as manager" do
    login_as(@user)
    get users_url
    assert_response :unauthorized
  end

  test "should create user when authenticated as manager" do
    login_as(@manager)
    assert_difference('User.count') do
      post users_url, params: { user: { name: "John Doe", email: "john.doe@example.com" } }
    end
    assert_response :created
  end

  test "should not create user when not authenticated as manager" do
    login_as(@user)
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: "John Doe", email: "john.doe@example.com" } }
    end
    assert_response :unauthorized
  end

  test "should delete user when authenticated as manager" do
    login_as(@manager)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    assert_response :success
  end

  test "should not delete user when not authenticated as manager" do
    login_as(@user)
    assert_no_difference('User.count') do
      delete user_url(@user)
    end
    assert_response :unauthorized
  end
end