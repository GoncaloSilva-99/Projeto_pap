require "application_system_test_case"

class BoardProfilesTest < ApplicationSystemTestCase
  setup do
    @board_profile = board_profiles(:one)
  end

  test "visiting the index" do
    visit board_profiles_url
    assert_selector "h1", text: "Board profiles"
  end

  test "should create board profile" do
    visit board_profiles_url
    click_on "New board profile"

    fill_in "Bio", with: @board_profile.bio
    fill_in "Birth date", with: @board_profile.birth_date
    fill_in "Club profile", with: @board_profile.club_profile_id
    fill_in "Name", with: @board_profile.name
    fill_in "Role", with: @board_profile.role
    fill_in "User", with: @board_profile.user_id
    click_on "Create Board profile"

    assert_text "Board profile was successfully created"
    click_on "Back"
  end

  test "should update Board profile" do
    visit board_profile_url(@board_profile)
    click_on "Edit this board profile", match: :first

    fill_in "Bio", with: @board_profile.bio
    fill_in "Birth date", with: @board_profile.birth_date
    fill_in "Club profile", with: @board_profile.club_profile_id
    fill_in "Name", with: @board_profile.name
    fill_in "Role", with: @board_profile.role
    fill_in "User", with: @board_profile.user_id
    click_on "Update Board profile"

    assert_text "Board profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Board profile" do
    visit board_profile_url(@board_profile)
    click_on "Destroy this board profile", match: :first

    assert_text "Board profile was successfully destroyed"
  end
end
