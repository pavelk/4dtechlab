require 'test_helper'

class SignupTest < ActionController::IntegrationTest

  test "signup with valid data" do
    visit new_user_url
    assert_response :success
    fill_in "user[email]", :with => "test_user@example.com"
    fill_in "user[password]", :with => "secret"
    fill_in "user[password_confirmation]", :with => "secret"
    fill_in "user[agency]", :with => "agency"
    fill_in "user[first_name]", :with => "name"
    fill_in "user[last_name]", :with => "surname"
    click_button "user_submit"
    assert true
  end
end