require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:jerry)
  end

  test "requires name" do
    user = User.new(name: "", email: "user@example.com", password: "password", password_confirmation: "password")
    assert_not user.valid?

    user.name = "John"
    assert user.valid?
  end

  test "requires email" do
    user = User.new(name: "John", email: "", password: "password", password_confirmation: "password")
    assert_not user.valid?

    user.email = "invalid"
    assert_not user.valid?

    user.email = "user@example.com"
    assert user.valid?
  end

  test "requires unique email" do
    user = User.new(name: "Jerry", email: "jerry@acme.com", password: "password", password_confirmation: "password")
    assert_not user.valid?

    user.email = "user@example.com"
    assert user.valid?
  end

  test "strips spaces from email and name" do
    user = User.new(name: " John ", email: " john@example.com ", password: "password", password_confirmation: "password")
    assert_equal "John", user.name
    assert_equal "john@example.com", user.email
  end

  test "requires password at least 8 characters" do
    user = User.new(name: "John", email: "john@example.com")
    assert_not user.valid?

    user.password = user.password_confirmation = "password"
    assert user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    user.password = user.password_confirmation = "a" * (max_length + 1)
    assert_not user.valid?
  end

  test "successful login" do
    login = User.login(email: "jerry@acme.com", password: "password")

    assert_not_nil login
    assert_not_nil login.token
  end

  test "failed login with incorrect password" do
    login = User.login(email: "jerry@acme.com", password: "wrong")

    assert_nil login
  end

  test "failed login with non-exsting email" do
    login = User.login(email: "wrong@example.com", password: "wrong")

    assert_nil login
  end

  test "successful authentication" do
    login = @user.logins.create
    assert_equal login, User.authenticate(id: @user.id, login_id: login.id, token: login.token)
  end

  test "failed authentication" do
    login = @user.logins.create
    assert_not User.authenticate(id: @user.id, login_id: login.id, token: "invalid")
  end
end
