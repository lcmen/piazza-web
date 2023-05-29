require 'test_helper'

class AuthenticationTestsController < TestController
  include Authentication

  allow_unauthenticated only: :new
  skip_authentication only: :show

  def new
    render plain: "User: #{Current.user&.id}"
  end

  def show
    render plain: "User: #{Current.user&.id}"
  end
end

class AuthenticationTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
    draw_test_routes do
      resource :authentication_test, only: %i[new show edit]
    end
  end

  teardown do
    reload_routes!
  end

  test "authenticated requests" do
    @user.logins.destroy_all
    login(@user, remember_me: false)

    get edit_authentication_test_path
    assert_response :ok
    assert_match /authentication_tests#edit/, response.body
  end

  test "requiring authentication" do
    get edit_authentication_test_path

    assert_response :redirect
    assert_redirected_to login_path
  end

  test "skipping authentication" do
    login(@user, remember_me: false)

    get authentication_test_path
    assert_response :ok
    assert_equal "User: ", response.body
  end

  test "allowing unauthenticated requests" do
    get new_authentication_test_path
    assert_response :ok
    assert_equal "User: ", response.body

    login(@user, remember_me: false)
    get new_authentication_test_path
    assert_response :ok
    assert_equal "User: #{@user.id}", response.body
  end
end
