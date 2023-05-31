require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "successful signup" do
    get sign_up_path
    assert_response :success
    assert_difference ["User.count", "Organization.count"], 1 do
      params = { name: "John", email: "john@example.com", password: "password", password_confirmation: "password" }
      post sign_up_path, params: { user: params }
    end
    assert_not_empty cookies[:login]
    assert_redirected_to root_path
    follow_redirect!
    assert_select ".notification.is-success", text: I18n.t('users.create.flash.success', name: "John")
  end

  test "failed signup" do
    get sign_up_path
    assert_response :success
    assert_no_difference ["User.count", "Organization.count"] do
      params = { name: "John", email: "john@example.com", password: "password", password_confirmation: "wrong" }
      post sign_up_path, params: { user: params }
    end
    assert_nil cookies[:login]
    assert_response :unprocessable_entity
    assert_template :new
  end
end
