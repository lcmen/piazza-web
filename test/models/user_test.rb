require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires name" do
    user = User.new(name: "", email: "user@example.com", password: "password")
    assert_not user.valid?

    user.name = "John"
    assert user.valid?
  end

  test "requires email" do
    user = User.new(name: "John", email: "", password: "password")
    assert_not user.valid?

    user.email = "invalid"
    assert_not user.valid?

    user.email = "user@example.com"
    assert user.valid?
  end

  test "requires unique email" do
    user = User.new(name: "John", email: "user1@example.com", password: "password")
    assert_not user.valid?

    user.email = "user@example.com"
    assert user.valid?
  end

  test "strips spaces from email and name" do
    user = User.new(name: " John ", email: " john@example.com ")
    assert_equal "John", user.name
    assert_equal "john@example.com", user.email
  end

  test "requires password at least 8 characters" do
    user = User.new(name: "John", email: "john@example.com", password: "")
    assert_not user.valid?

    user.password = "password"
    assert user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    user.password = "a" * (max_length + 1)
    assert_not user.valid?
  end
end
