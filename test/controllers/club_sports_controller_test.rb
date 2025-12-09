require "test_helper"

class ClubSportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_sport = club_sports(:one)
  end

  test "should get index" do
    get club_sports_url
    assert_response :success
  end

  test "should get new" do
    get new_club_sport_url
    assert_response :success
  end

  test "should create club_sport" do
    assert_difference("ClubSport.count") do
      post club_sports_url, params: { club_sport: { club_profiles_id: @club_sport.club_profile_id, sports_id: @club_sport.sport_id } }
    end

    assert_redirected_to club_sport_url(ClubSport.last)
  end

  test "should show club_sport" do
    get club_sport_url(@club_sport)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_sport_url(@club_sport)
    assert_response :success
  end

  test "should update club_sport" do
    patch club_sport_url(@club_sport), params: { club_sport: { club_profiles_id: @club_sport.club_profile_id, sports_id: @club_sport.sport_id } }
    assert_redirected_to club_sport_url(@club_sport)
  end

  test "should destroy club_sport" do
    assert_difference("ClubSport.count", -1) do
      delete club_sport_url(@club_sport)
    end

    assert_redirected_to club_sports_url
  end
end
