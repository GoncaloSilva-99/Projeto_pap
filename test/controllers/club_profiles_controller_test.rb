require "test_helper"

class ClubProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_profile = club_profiles(:one)
  end

  test "should get index" do
    get club_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_club_profile_url
    assert_response :success
  end

  test "should create club_profile" do
    assert_difference("ClubProfile.count") do
      post club_profiles_url, params: { club_profile: { approved_by: @club_profile.approved_by, name: @club_profile.name, status: @club_profile.status, user_id: @club_profile.user_id } }
    end

    assert_redirected_to club_profile_url(ClubProfile.last)
  end

  test "should show club_profile" do
    get club_profile_url(@club_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_profile_url(@club_profile)
    assert_response :success
  end

  test "should update club_profile" do
    patch club_profile_url(@club_profile), params: { club_profile: { approved_by: @club_profile.approved_by, name: @club_profile.name, status: @club_profile.status, user_id: @club_profile.user_id } }
    assert_redirected_to club_profile_url(@club_profile)
  end

  test "should destroy club_profile" do
    assert_difference("ClubProfile.count", -1) do
      delete club_profile_url(@club_profile)
    end

    assert_redirected_to club_profiles_url
  end
end
