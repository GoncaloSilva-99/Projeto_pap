require "test_helper"

class ClubTeamTrainingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_team_training = club_team_trainings(:one)
  end

  test "should get index" do
    get club_team_trainings_url
    assert_response :success
  end

  test "should get new" do
    get new_club_team_training_url
    assert_response :success
  end

  test "should create club_team_training" do
    assert_difference("ClubTeamTraining.count") do
      post club_team_trainings_url, params: { club_team_training: { club_locker_room_id: @club_team_training.club_locker_room_id, club_pitch_id: @club_team_training.club_pitch_id, club_team_id: @club_team_training.club_team_id, end_time: @club_team_training.end_time, recurring: @club_team_training.recurring, start_time: @club_team_training.start_time, weekday: @club_team_training.weekday } }
    end

    assert_redirected_to club_team_training_url(ClubTeamTraining.last)
  end

  test "should show club_team_training" do
    get club_team_training_url(@club_team_training)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_team_training_url(@club_team_training)
    assert_response :success
  end

  test "should update club_team_training" do
    patch club_team_training_url(@club_team_training), params: { club_team_training: { club_locker_room_id: @club_team_training.club_locker_room_id, club_pitch_id: @club_team_training.club_pitch_id, club_team_id: @club_team_training.club_team_id, end_time: @club_team_training.end_time, recurring: @club_team_training.recurring, start_time: @club_team_training.start_time, weekday: @club_team_training.weekday } }
    assert_redirected_to club_team_training_url(@club_team_training)
  end

  test "should destroy club_team_training" do
    assert_difference("ClubTeamTraining.count", -1) do
      delete club_team_training_url(@club_team_training)
    end

    assert_redirected_to club_team_trainings_url
  end
end
