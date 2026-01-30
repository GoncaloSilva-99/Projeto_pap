require "application_system_test_case"

class PlayerTeamsTest < ApplicationSystemTestCase
  setup do
    @player_team = player_teams(:one)
  end

  test "visiting the index" do
    visit player_teams_url
    assert_selector "h1", text: "Player teams"
  end

  test "should create player team" do
    visit player_teams_url
    click_on "New player team"

    fill_in "Club teams", with: @player_team.club_teams_id
    fill_in "Player profiles", with: @player_team.player_profiles_id
    click_on "Create Player team"

    assert_text "Player team was successfully created"
    click_on "Back"
  end

  test "should update Player team" do
    visit player_team_url(@player_team)
    click_on "Edit this player team", match: :first

    fill_in "Club teams", with: @player_team.club_teams_id
    fill_in "Player profiles", with: @player_team.player_profiles_id
    click_on "Update Player team"

    assert_text "Player team was successfully updated"
    click_on "Back"
  end

  test "should destroy Player team" do
    visit player_team_url(@player_team)
    accept_confirm { click_on "Destroy this player team", match: :first }

    assert_text "Player team was successfully destroyed"
  end
end
