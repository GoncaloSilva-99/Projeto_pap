require "application_system_test_case"

class ClubTeamsTest < ApplicationSystemTestCase
  setup do
    @club_team = club_teams(:one)
  end

  test "visiting the index" do
    visit club_teams_url
    assert_selector "h1", text: "Club teams"
  end

  test "should create club team" do
    visit club_teams_url
    click_on "New club team"

    fill_in "Club profiles", with: @club_team.club_profiles_id
    fill_in "Name", with: @club_team.name
    fill_in "Sports", with: @club_team.sports_id
    click_on "Create Club team"

    assert_text "Club team was successfully created"
    click_on "Back"
  end

  test "should update Club team" do
    visit club_team_url(@club_team)
    click_on "Edit this club team", match: :first

    fill_in "Club profiles", with: @club_team.club_profiles_id
    fill_in "Name", with: @club_team.name
    fill_in "Sports", with: @club_team.sports_id
    click_on "Update Club team"

    assert_text "Club team was successfully updated"
    click_on "Back"
  end

  test "should destroy Club team" do
    visit club_team_url(@club_team)
    accept_confirm { click_on "Destroy this club team", match: :first }

    assert_text "Club team was successfully destroyed"
  end
end
