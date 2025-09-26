require "application_system_test_case"

class PlayerProfilesTest < ApplicationSystemTestCase
  setup do
    @player_profile = player_profiles(:one)
  end

  test "visiting the index" do
    visit player_profiles_url
    assert_selector "h1", text: "Player profiles"
  end

  test "should create player profile" do
    visit player_profiles_url
    click_on "New player profile"

    fill_in "Bio", with: @player_profile.bio
    fill_in "Birth date", with: @player_profile.birth_date
    fill_in "Club profile", with: @player_profile.club_profile_id
    fill_in "Contact", with: @player_profile.contact
    fill_in "Name", with: @player_profile.name
    fill_in "Parents contact", with: @player_profile.parents_contact
    fill_in "Position", with: @player_profile.position
    fill_in "User", with: @player_profile.user_id
    click_on "Create Player profile"

    assert_text "Player profile was successfully created"
    click_on "Back"
  end

  test "should update Player profile" do
    visit player_profile_url(@player_profile)
    click_on "Edit this player profile", match: :first

    fill_in "Bio", with: @player_profile.bio
    fill_in "Birth date", with: @player_profile.birth_date
    fill_in "Club profile", with: @player_profile.club_profile_id
    fill_in "Contact", with: @player_profile.contact
    fill_in "Name", with: @player_profile.name
    fill_in "Parents contact", with: @player_profile.parents_contact
    fill_in "Position", with: @player_profile.position
    fill_in "User", with: @player_profile.user_id
    click_on "Update Player profile"

    assert_text "Player profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Player profile" do
    visit player_profile_url(@player_profile)
    click_on "Destroy this player profile", match: :first

    assert_text "Player profile was successfully destroyed"
  end
end
