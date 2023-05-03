require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "successful signup" do
    get sign_up_path
    assert_response :success
    assert_difference ["User.count", "Organization.count"], 1 do
      params = { user: { name: "John", email: "john@example.com", password: "password" } }
      post sign_up_path, params:
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_select ".notification.is-success", text: I18n.t('users.create.welcome', name: "John")
  end

  test "failed signup" do
    get sign_up_path
    assert_response :success
    assert_no_difference ["User.count", "Organization.count"] do
      params = { user: { name: "John", email: "john@example.com", password: "pass" } }
      post sign_up_path, params:
    end
    assert_response :unprocessable_entity
  end
end
