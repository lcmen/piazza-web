require "test_helper"

class LoginTest < ActiveSupport::TestCase
  setup do
    @user = users(:jerry)
  end

  test "creation with token" do
    login = @user.logins.create

    assert login.persisted?
    assert_not_nil login.token_digest
    assert login.authenticate_token(login.token)
  end
end
