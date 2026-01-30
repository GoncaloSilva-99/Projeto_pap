require "test_helper"

class ClubTeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_team = club_teams(:one)
  end

  test "should get index" do
    get club_teams_url
    assert_response :success
  end

  test "should get new" do
    get new_club_team_url
    assert_response :success
  end

  test "should create club_team" do
    assert_difference("ClubTeam.count") do
      post club_teams_url, params: { club_team: { club_profiles_id: @club_team.club_profiles_id, name: @club_team.name, sports_id: @club_team.sports_id } }
    end

    assert_redirected_to club_team_url(ClubTeam.last)
  end

  test "should show club_team" do
    get club_team_url(@club_team)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_team_url(@club_team)
    assert_response :success
  end

  test "should update club_team" do
    patch club_team_url(@club_team), params: { club_team: { club_profiles_id: @club_team.club_profiles_id, name: @club_team.name, sports_id: @club_team.sports_id } }
    assert_redirected_to club_team_url(@club_team)
  end

  test "should destroy club_team" do
    assert_difference("ClubTeam.count", -1) do
      delete club_team_url(@club_team)
    end

    assert_redirected_to club_teams_url
  end
end
