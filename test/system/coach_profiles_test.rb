require "application_system_test_case"

class CoachProfilesTest < ApplicationSystemTestCase
  setup do
    @coach_profile = coach_profiles(:one)
  end

  test "visiting the index" do
    visit coach_profiles_url
    assert_selector "h1", text: "Coach profiles"
  end

  test "should create coach profile" do
    visit coach_profiles_url
    click_on "New coach profile"

    fill_in "Birth date", with: @coach_profile.birth_date
    fill_in "Club", with: @coach_profile.club_id
    fill_in "Coach type", with: @coach_profile.coach_type
    fill_in "Name", with: @coach_profile.name
    fill_in "User", with: @coach_profile.user_id
    click_on "Create Coach profile"

    assert_text "Coach profile was successfully created"
    click_on "Back"
  end

  test "should update Coach profile" do
    visit coach_profile_url(@coach_profile)
    click_on "Edit this coach profile", match: :first

    fill_in "Birth date", with: @coach_profile.birth_date
    fill_in "Club", with: @coach_profile.club_id
    fill_in "Coach type", with: @coach_profile.coach_type
    fill_in "Name", with: @coach_profile.name
    fill_in "User", with: @coach_profile.user_id
    click_on "Update Coach profile"

    assert_text "Coach profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Coach profile" do
    visit coach_profile_url(@coach_profile)
    click_on "Destroy this coach profile", match: :first

    assert_text "Coach profile was successfully destroyed"
  end
end
