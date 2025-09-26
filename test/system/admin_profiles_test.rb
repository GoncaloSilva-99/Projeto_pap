require "application_system_test_case"

class AdminProfilesTest < ApplicationSystemTestCase
  setup do
    @admin_profile = admin_profiles(:one)
  end

  test "visiting the index" do
    visit admin_profiles_url
    assert_selector "h1", text: "Admin profiles"
  end

  test "should create admin profile" do
    visit admin_profiles_url
    click_on "New admin profile"

    fill_in "Name", with: @admin_profile.name
    fill_in "User", with: @admin_profile.user_id
    click_on "Create Admin profile"

    assert_text "Admin profile was successfully created"
    click_on "Back"
  end

  test "should update Admin profile" do
    visit admin_profile_url(@admin_profile)
    click_on "Edit this admin profile", match: :first

    fill_in "Name", with: @admin_profile.name
    fill_in "User", with: @admin_profile.user_id
    click_on "Update Admin profile"

    assert_text "Admin profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Admin profile" do
    visit admin_profile_url(@admin_profile)
    click_on "Destroy this admin profile", match: :first

    assert_text "Admin profile was successfully destroyed"
  end
end
