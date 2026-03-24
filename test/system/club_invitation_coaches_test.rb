require "application_system_test_case"

class ClubInvitationCoachesTest < ApplicationSystemTestCase
  setup do
    @club_invitation_coach = club_invitation_coaches(:one)
  end

  test "visiting the index" do
    visit club_invitation_coaches_url
    assert_selector "h1", text: "Club invitation coaches"
  end

  test "should create club invitation coach" do
    visit club_invitation_coaches_url
    click_on "New club invitation coach"

    fill_in "Club profile", with: @club_invitation_coach.club_profile_id
    fill_in "Coach profile", with: @club_invitation_coach.coach_profile_id
    fill_in "Status", with: @club_invitation_coach.status
    click_on "Create Club invitation coach"

    assert_text "Club invitation coach was successfully created"
    click_on "Back"
  end

  test "should update Club invitation coach" do
    visit club_invitation_coach_url(@club_invitation_coach)
    click_on "Edit this club invitation coach", match: :first

    fill_in "Club profile", with: @club_invitation_coach.club_profile_id
    fill_in "Coach profile", with: @club_invitation_coach.coach_profile_id
    fill_in "Status", with: @club_invitation_coach.status
    click_on "Update Club invitation coach"

    assert_text "Club invitation coach was successfully updated"
    click_on "Back"
  end

  test "should destroy Club invitation coach" do
    visit club_invitation_coach_url(@club_invitation_coach)
    accept_confirm { click_on "Destroy this club invitation coach", match: :first }

    assert_text "Club invitation coach was successfully destroyed"
  end
end
