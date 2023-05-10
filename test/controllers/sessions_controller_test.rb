require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
  end

  test "successful login" do
    assert_difference("@user.logins.count", 1) do
      login(@user)
    end
    assert_not_empty cookies[:login]
    assert_redirected_to root_path
  end

  test "failed login" do
    assert_no_difference("@user.logins.count") do
      login(@user, "wrong")
    end
    assert_nil cookies[:login]
    assert_response :unprocessable_entity
    assert_template :new
  end
end
