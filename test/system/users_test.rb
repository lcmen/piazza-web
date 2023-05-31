require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "user signups" do
    visit root_path

    click_on I18n.t("shared.navbar.sign_up")
    fill_in User.human_attribute_name(:name), with: "Bob"
    fill_in User.human_attribute_name(:email), with: "bob@example.com"
    fill_in User.human_attribute_name(:password), with: "short"
    fill_in User.human_attribute_name(:password_confirmation), with: "short"
    click_button I18n.t("users.new.sign_up")

    assert_selector "p.is-danger", text: I18n.t("activerecord.errors.messages.too_short", count: 8)

    fill_in User.human_attribute_name(:password), with: "password"
    fill_in User.human_attribute_name(:password_confirmation), with: "password"
    click_button I18n.t("users.new.sign_up")

    assert_current_path root_path
    assert_selector ".notification.is-success", text: I18n.t("users.create.flash.success", name: "Bob")
    assert_selector ".navbar-dropdown", visible: false
  end

  test "user logins" do
    visit root_path

    click_on I18n.t("shared.navbar.login")
    fill_in User.human_attribute_name(:email), with: "jerry@acme.com"
    fill_in User.human_attribute_name(:password), with: "wrong"
    click_button I18n.t("sessions.new.login")

    assert_selector ".notification.is-danger", text: I18n.t("sessions.create.flash.failure")

    fill_in User.human_attribute_name(:email), with: "jerry@acme.com"
    fill_in User.human_attribute_name(:password), with: "password"
    click_button I18n.t("sessions.new.login")

    assert_current_path root_path
    assert_selector ".notification.is-success", text: I18n.t("sessions.create.flash.success")
    assert_selector ".navbar-dropdown", visible: false
  end
end
