require "application_system_test_case"

class CoachTeamsTest < ApplicationSystemTestCase
  setup do
    @coach_team = coach_teams(:one)
  end

  test "visiting the index" do
    visit coach_teams_url
    assert_selector "h1", text: "Coach teams"
  end

  test "should create coach team" do
    visit coach_teams_url
    click_on "New coach team"

    fill_in "Club teams", with: @coach_team.club_teams_id
    fill_in "Coach profiles", with: @coach_team.coach_profiles_id
    click_on "Create Coach team"

    assert_text "Coach team was successfully created"
    click_on "Back"
  end

  test "should update Coach team" do
    visit coach_team_url(@coach_team)
    click_on "Edit this coach team", match: :first

    fill_in "Club teams", with: @coach_team.club_teams_id
    fill_in "Coach profiles", with: @coach_team.coach_profiles_id
    click_on "Update Coach team"

    assert_text "Coach team was successfully updated"
    click_on "Back"
  end

  test "should destroy Coach team" do
    visit coach_team_url(@coach_team)
    accept_confirm { click_on "Destroy this coach team", match: :first }

    assert_text "Coach team was successfully destroyed"
  end
end
