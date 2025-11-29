require "test_helper"

class CoachTeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coach_team = coach_teams(:one)
  end

  test "should get index" do
    get coach_teams_url
    assert_response :success
  end

  test "should get new" do
    get new_coach_team_url
    assert_response :success
  end

  test "should create coach_team" do
    assert_difference("CoachTeam.count") do
      post coach_teams_url, params: { coach_team: { club_teams_id: @coach_team.club_teams_id, coach_profiles_id: @coach_team.coach_profiles_id } }
    end

    assert_redirected_to coach_team_url(CoachTeam.last)
  end

  test "should show coach_team" do
    get coach_team_url(@coach_team)
    assert_response :success
  end

  test "should get edit" do
    get edit_coach_team_url(@coach_team)
    assert_response :success
  end

  test "should update coach_team" do
    patch coach_team_url(@coach_team), params: { coach_team: { club_teams_id: @coach_team.club_teams_id, coach_profiles_id: @coach_team.coach_profiles_id } }
    assert_redirected_to coach_team_url(@coach_team)
  end

  test "should destroy coach_team" do
    assert_difference("CoachTeam.count", -1) do
      delete coach_team_url(@coach_team)
    end

    assert_redirected_to coach_teams_url
  end
end
