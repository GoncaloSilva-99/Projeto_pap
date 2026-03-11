require "application_system_test_case"

class ReportProfilesTest < ApplicationSystemTestCase
  setup do
    @report_profile = report_profiles(:one)
  end

  test "visiting the index" do
    visit report_profiles_url
    assert_selector "h1", text: "Report profiles"
  end

  test "should create report profile" do
    visit report_profiles_url
    click_on "New report profile"

    fill_in "Content", with: @report_profile.content
    check "Resolved" if @report_profile.resolved
    fill_in "Users", with: @report_profile.users_id
    click_on "Create Report profile"

    assert_text "Report profile was successfully created"
    click_on "Back"
  end

  test "should update Report profile" do
    visit report_profile_url(@report_profile)
    click_on "Edit this report profile", match: :first

    fill_in "Content", with: @report_profile.content
    check "Resolved" if @report_profile.resolved
    fill_in "Users", with: @report_profile.users_id
    click_on "Update Report profile"

    assert_text "Report profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Report profile" do
    visit report_profile_url(@report_profile)
    accept_confirm { click_on "Destroy this report profile", match: :first }

    assert_text "Report profile was successfully destroyed"
  end
end
