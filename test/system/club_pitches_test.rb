require "application_system_test_case"

class ClubPitchesTest < ApplicationSystemTestCase
  setup do
    @club_pitch = club_pitches(:one)
  end

  test "visiting the index" do
    visit club_pitches_url
    assert_selector "h1", text: "Club pitches"
  end

  test "should create club pitch" do
    visit club_pitches_url
    click_on "New club pitch"

    fill_in "Club profiles", with: @club_pitch.club_profiles_id
    fill_in "Club training centers", with: @club_pitch.club_training_centers_id
    fill_in "Name", with: @club_pitch.name
    fill_in "Sports", with: @club_pitch.sports_id
    click_on "Create Club pitch"

    assert_text "Club pitch was successfully created"
    click_on "Back"
  end

  test "should update Club pitch" do
    visit club_pitch_url(@club_pitch)
    click_on "Edit this club pitch", match: :first

    fill_in "Club profiles", with: @club_pitch.club_profiles_id
    fill_in "Club training centers", with: @club_pitch.club_training_centers_id
    fill_in "Name", with: @club_pitch.name
    fill_in "Sports", with: @club_pitch.sports_id
    click_on "Update Club pitch"

    assert_text "Club pitch was successfully updated"
    click_on "Back"
  end

  test "should destroy Club pitch" do
    visit club_pitch_url(@club_pitch)
    accept_confirm { click_on "Destroy this club pitch", match: :first }

    assert_text "Club pitch was successfully destroyed"
  end
end
