require "application_system_test_case"

class ClubTeamTrainingsTest < ApplicationSystemTestCase
  setup do
    @club_team_training = club_team_trainings(:one)
  end

  test "visiting the index" do
    visit club_team_trainings_url
    assert_selector "h1", text: "Club team trainings"
  end

  test "should create club team training" do
    visit club_team_trainings_url
    click_on "New club team training"

    fill_in "Club locker room", with: @club_team_training.club_locker_room_id
    fill_in "Club pitch", with: @club_team_training.club_pitch_id
    fill_in "Club team", with: @club_team_training.club_team_id
    fill_in "End time", with: @club_team_training.end_time
    check "Recurring" if @club_team_training.recurring
    fill_in "Start time", with: @club_team_training.start_time
    fill_in "Weekday", with: @club_team_training.weekday
    click_on "Create Club team training"

    assert_text "Club team training was successfully created"
    click_on "Back"
  end

  test "should update Club team training" do
    visit club_team_training_url(@club_team_training)
    click_on "Edit this club team training", match: :first

    fill_in "Club locker room", with: @club_team_training.club_locker_room_id
    fill_in "Club pitch", with: @club_team_training.club_pitch_id
    fill_in "Club team", with: @club_team_training.club_team_id
    fill_in "End time", with: @club_team_training.end_time.to_s
    check "Recurring" if @club_team_training.recurring
    fill_in "Start time", with: @club_team_training.start_time.to_s
    fill_in "Weekday", with: @club_team_training.weekday
    click_on "Update Club team training"

    assert_text "Club team training was successfully updated"
    click_on "Back"
  end

  test "should destroy Club team training" do
    visit club_team_training_url(@club_team_training)
    accept_confirm { click_on "Destroy this club team training", match: :first }

    assert_text "Club team training was successfully destroyed"
  end
end
