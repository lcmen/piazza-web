require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "name presence validation" do
    user = User.new(name: "", email: "user@example.com", password: "password", password_confirmation: "password")
    assert_not user.valid?

    user.name = "John"
    assert user.valid?
  end

  test "email presence validation" do
    user = User.new(name: "John", email: "", password: "password", password_confirmation: "password")
    assert_not user.valid?

    user.email = "invalid"
    assert_not user.valid?

    user.email = "user@example.com"
    assert user.valid?
  end

  test "email unique validation" do
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
end
