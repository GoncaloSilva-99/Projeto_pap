require "test_helper"

class ClubInvitationCoachesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_invitation_coach = club_invitation_coaches(:one)
  end

  test "should get index" do
    get club_invitation_coaches_url
    assert_response :success
  end

  test "should get new" do
    get new_club_invitation_coach_url
    assert_response :success
  end

  test "should create club_invitation_coach" do
    assert_difference("ClubInvitationCoach.count") do
      post club_invitation_coaches_url, params: { club_invitation_coach: { club_profile_id: @club_invitation_coach.club_profile_id, coach_profile_id: @club_invitation_coach.coach_profile_id, status: @club_invitation_coach.status } }
    end

    assert_redirected_to club_invitation_coach_url(ClubInvitationCoach.last)
  end

  test "should show club_invitation_coach" do
    get club_invitation_coach_url(@club_invitation_coach)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_invitation_coach_url(@club_invitation_coach)
    assert_response :success
  end

  test "should update club_invitation_coach" do
    patch club_invitation_coach_url(@club_invitation_coach), params: { club_invitation_coach: { club_profile_id: @club_invitation_coach.club_profile_id, coach_profile_id: @club_invitation_coach.coach_profile_id, status: @club_invitation_coach.status } }
    assert_redirected_to club_invitation_coach_url(@club_invitation_coach)
  end

  test "should destroy club_invitation_coach" do
    assert_difference("ClubInvitationCoach.count", -1) do
      delete club_invitation_coach_url(@club_invitation_coach)
    end

    assert_redirected_to club_invitation_coaches_url
  end
end
