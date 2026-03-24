require "application_system_test_case"

class ClubInvitationPlayersTest < ApplicationSystemTestCase
  setup do
    @club_invitation_player = club_invitation_players(:one)
  end

  test "visiting the index" do
    visit club_invitation_players_url
    assert_selector "h1", text: "Club invitation players"
  end

  test "should create club invitation player" do
    visit club_invitation_players_url
    click_on "New club invitation player"

    fill_in "Club profile", with: @club_invitation_player.club_profile_id
    fill_in "Player profile", with: @club_invitation_player.player_profile_id
    fill_in "Status", with: @club_invitation_player.status
    click_on "Create Club invitation player"

    assert_text "Club invitation player was successfully created"
    click_on "Back"
  end

  test "should update Club invitation player" do
    visit club_invitation_player_url(@club_invitation_player)
    click_on "Edit this club invitation player", match: :first

    fill_in "Club profile", with: @club_invitation_player.club_profile_id
    fill_in "Player profile", with: @club_invitation_player.player_profile_id
    fill_in "Status", with: @club_invitation_player.status
    click_on "Update Club invitation player"

    assert_text "Club invitation player was successfully updated"
    click_on "Back"
  end

  test "should destroy Club invitation player" do
    visit club_invitation_player_url(@club_invitation_player)
    accept_confirm { click_on "Destroy this club invitation player", match: :first }

    assert_text "Club invitation player was successfully destroyed"
  end
end
