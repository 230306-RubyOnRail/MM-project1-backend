require './test/test_helper'

class SessionsControllerTest <  ActionDispatch::IntegrationTest
  test "should create token with valid credentials" do
    post "/auth/login", params: { email: 'karl@localhost.com', password_digest: "mypassword" }, as: :json
    assert_response :created
    assert_not_nil response.parsed_body["token"]
    assert_equal user.id, response.parsed_body["user_id"]
  end
end
