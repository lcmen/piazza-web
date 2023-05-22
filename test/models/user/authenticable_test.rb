require "test_helper"

class User::AuthenticableTest < ActiveSupport::TestCase
  test "password length validation" do
    user = User.new(name: "John", email: "john@example.com")
    assert_not user.valid?

    user.password = user.password_confirmation = "password"
    assert user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    user.password = user.password_confirmation = "a" * (max_length + 1)
    assert_not user.valid?
  end

  test "login with correct email and password" do
    login = User.login(email: "jerry@acme.com", password: "password")

    assert_not_nil login
    assert_not_nil login.token
  end

  test "login with invalid password" do
    login = User.login(email: "jerry@acme.com", password: "wrong")

    assert_nil login
  end

  test "login with non-existing email" do
    login = User.login(email: "wrong@example.com", password: "wrong")

    assert_nil login
  end

  test "authenticate with valid token" do
    user = users(:jerry)
    login = user.logins.create
    assert_equal login, User.authenticate(id: user.id, login_id: login.id, token: login.token)
  end

  test "authenticate with invalid token" do
    user = users(:jerry)
    login = user.logins.create
    assert_not User.authenticate(id: user.id, login_id: login.id, token: "invalid")
  end
end
