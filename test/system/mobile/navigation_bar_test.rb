require "application_system_test_case"

class NavgiationBarTest < MobileSystemTestCase
  test "access signup page via burger menu" do
    find(".navbar-burger").click
    click_on I18n.t("shared.navbar.sign_up")
    assert_current_path sign_up_path
  end

  test "access login page via burger menu" do
    find(".navbar-burger").click
    click_on I18n.t("shared.navbar.login")
    assert_current_path login_path
  end
end
