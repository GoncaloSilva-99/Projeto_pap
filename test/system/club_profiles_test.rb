require "application_system_test_case"

class ClubProfilesTest < ApplicationSystemTestCase
  setup do
    @club_profile = club_profiles(:one)
  end

  test "visiting the index" do
    visit club_profiles_url
    assert_selector "h1", text: "Club profiles"
  end

  test "should create club profile" do
    visit club_profiles_url
    click_on "New club profile"

    fill_in "Approved by", with: @club_profile.approved_by
    fill_in "Name", with: @club_profile.name
    check "Status" if @club_profile.status
    fill_in "User", with: @club_profile.user_id
    click_on "Create Club profile"

    assert_text "Club profile was successfully created"
    click_on "Back"
  end

  test "should update Club profile" do
    visit club_profile_url(@club_profile)
    click_on "Edit this club profile", match: :first

    fill_in "Approved by", with: @club_profile.approved_by
    fill_in "Name", with: @club_profile.name
    check "Status" if @club_profile.status
    fill_in "User", with: @club_profile.user_id
    click_on "Update Club profile"

    assert_text "Club profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Club profile" do
    visit club_profile_url(@club_profile)
    click_on "Destroy this club profile", match: :first

    assert_text "Club profile was successfully destroyed"
  end
end
