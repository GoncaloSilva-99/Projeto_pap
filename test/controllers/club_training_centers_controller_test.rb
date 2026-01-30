require "test_helper"

class ClubTrainingCentersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_training_center = club_training_centers(:one)
  end

  test "should get index" do
    get club_training_centers_url
    assert_response :success
  end

  test "should get new" do
    get new_club_training_center_url
    assert_response :success
  end

  test "should create club_training_center" do
    assert_difference("ClubTrainingCenter.count") do
      post club_training_centers_url, params: { club_training_center: { club_profile_id: @club_training_center.club_profile_id, name: @club_training_center.name } }
    end

    assert_redirected_to club_training_center_url(ClubTrainingCenter.last)
  end

  test "should show club_training_center" do
    get club_training_center_url(@club_training_center)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_training_center_url(@club_training_center)
    assert_response :success
  end

  test "should update club_training_center" do
    patch club_training_center_url(@club_training_center), params: { club_training_center: { club_profile_id: @club_training_center.club_profile_id, name: @club_training_center.name } }
    assert_redirected_to club_training_center_url(@club_training_center)
  end

  test "should destroy club_training_center" do
    assert_difference("ClubTrainingCenter.count", -1) do
      delete club_training_center_url(@club_training_center)
    end

    assert_redirected_to club_training_centers_url
  end
end
