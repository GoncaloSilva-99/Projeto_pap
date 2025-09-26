require "test_helper"

class CoachProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coach_profile = coach_profiles(:one)
  end

  test "should get index" do
    get coach_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_coach_profile_url
    assert_response :success
  end

  test "should create coach_profile" do
    assert_difference("CoachProfile.count") do
      post coach_profiles_url, params: { coach_profile: { birth_date: @coach_profile.birth_date, club_id: @coach_profile.club_id, coach_type: @coach_profile.coach_type, name: @coach_profile.name, user_id: @coach_profile.user_id } }
    end

    assert_redirected_to coach_profile_url(CoachProfile.last)
  end

  test "should show coach_profile" do
    get coach_profile_url(@coach_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_coach_profile_url(@coach_profile)
    assert_response :success
  end

  test "should update coach_profile" do
    patch coach_profile_url(@coach_profile), params: { coach_profile: { birth_date: @coach_profile.birth_date, club_id: @coach_profile.club_id, coach_type: @coach_profile.coach_type, name: @coach_profile.name, user_id: @coach_profile.user_id } }
    assert_redirected_to coach_profile_url(@coach_profile)
  end

  test "should destroy coach_profile" do
    assert_difference("CoachProfile.count", -1) do
      delete coach_profile_url(@coach_profile)
    end

    assert_redirected_to coach_profiles_url
  end
end
