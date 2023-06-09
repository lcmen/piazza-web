require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
  end

  test "successful login" do
    assert_difference("@user.logins.count", 1) do
      login(@user, remember_me: false)
    end
    assert_not_empty cookies[:login]
    assert_nil raw_cookie(:login).expires
    assert_redirected_to root_path
  end

  test "successful login with remember me" do
    assert_difference("@user.logins.count", 1) do
      login(@user, remember_me: true)
    end
    assert_not_empty cookies[:login]
    assert raw_cookie(:login).expires
    assert_redirected_to root_path
  end

  test "failed login" do
    assert_no_difference("@user.logins.count") do
      login(@user, "wrong", remember_me: false)
    end
    assert_nil cookies[:login]
    assert_response :unprocessable_entity
    assert_template :new
  end

  test "logout" do
    login(@user, remember_me: false)

    assert_difference("@user.logins.count", -1) do
      logout
    end

    assert_redirected_to root_path
  end
end
