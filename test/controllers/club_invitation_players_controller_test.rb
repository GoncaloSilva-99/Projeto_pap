require "test_helper"

class ClubInvitationPlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_invitation_player = club_invitation_players(:one)
  end

  test "should get index" do
    get club_invitation_players_url
    assert_response :success
  end

  test "should get new" do
    get new_club_invitation_player_url
    assert_response :success
  end

  test "should create club_invitation_player" do
    assert_difference("ClubInvitationPlayer.count") do
      post club_invitation_players_url, params: { club_invitation_player: { club_profile_id: @club_invitation_player.club_profile_id, player_profile_id: @club_invitation_player.player_profile_id, status: @club_invitation_player.status } }
    end

    assert_redirected_to club_invitation_player_url(ClubInvitationPlayer.last)
  end

  test "should show club_invitation_player" do
    get club_invitation_player_url(@club_invitation_player)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_invitation_player_url(@club_invitation_player)
    assert_response :success
  end

  test "should update club_invitation_player" do
    patch club_invitation_player_url(@club_invitation_player), params: { club_invitation_player: { club_profile_id: @club_invitation_player.club_profile_id, player_profile_id: @club_invitation_player.player_profile_id, status: @club_invitation_player.status } }
    assert_redirected_to club_invitation_player_url(@club_invitation_player)
  end

  test "should destroy club_invitation_player" do
    assert_difference("ClubInvitationPlayer.count", -1) do
      delete club_invitation_player_url(@club_invitation_player)
    end

    assert_redirected_to club_invitation_players_url
  end
end
