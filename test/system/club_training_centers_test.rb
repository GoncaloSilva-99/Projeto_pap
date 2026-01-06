require "application_system_test_case"

class ClubTrainingCentersTest < ApplicationSystemTestCase
  setup do
    @club_training_center = club_training_centers(:one)
  end

  test "visiting the index" do
    visit club_training_centers_url
    assert_selector "h1", text: "Club training centers"
  end

  test "should create club training center" do
    visit club_training_centers_url
    click_on "New club training center"

    fill_in "Club profile", with: @club_training_center.club_profile_id
    fill_in "Name", with: @club_training_center.name
    click_on "Create Club training center"

    assert_text "Club training center was successfully created"
    click_on "Back"
  end

  test "should update Club training center" do
    visit club_training_center_url(@club_training_center)
    click_on "Edit this club training center", match: :first

    fill_in "Club profile", with: @club_training_center.club_profile_id
    fill_in "Name", with: @club_training_center.name
    click_on "Update Club training center"

    assert_text "Club training center was successfully updated"
    click_on "Back"
  end

  test "should destroy Club training center" do
    visit club_training_center_url(@club_training_center)
    accept_confirm { click_on "Destroy this club training center", match: :first }

    assert_text "Club training center was successfully destroyed"
  end
end
