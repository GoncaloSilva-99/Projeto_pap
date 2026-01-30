require "test_helper"

class ClubPitchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_pitch = club_pitches(:one)
  end

  test "should get index" do
    get club_pitches_url
    assert_response :success
  end

  test "should get new" do
    get new_club_pitch_url
    assert_response :success
  end

  test "should create club_pitch" do
    assert_difference("ClubPitch.count") do
      post club_pitches_url, params: { club_pitch: { club_profiles_id: @club_pitch.club_profiles_id, club_training_centers_id: @club_pitch.club_training_centers_id, name: @club_pitch.name, sports_id: @club_pitch.sports_id } }
    end

    assert_redirected_to club_pitch_url(ClubPitch.last)
  end

  test "should show club_pitch" do
    get club_pitch_url(@club_pitch)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_pitch_url(@club_pitch)
    assert_response :success
  end

  test "should update club_pitch" do
    patch club_pitch_url(@club_pitch), params: { club_pitch: { club_profiles_id: @club_pitch.club_profiles_id, club_training_centers_id: @club_pitch.club_training_centers_id, name: @club_pitch.name, sports_id: @club_pitch.sports_id } }
    assert_redirected_to club_pitch_url(@club_pitch)
  end

  test "should destroy club_pitch" do
    assert_difference("ClubPitch.count", -1) do
      delete club_pitch_url(@club_pitch)
    end

    assert_redirected_to club_pitches_url
  end
end
