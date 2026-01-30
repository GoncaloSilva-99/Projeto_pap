require "application_system_test_case"

class ClubSportsTest < ApplicationSystemTestCase
  setup do
    @club_sport = club_sports(:one)
  end

  test "visiting the index" do
    visit club_sports_url
    assert_selector "h1", text: "Club sports"
  end

  test "should create club sport" do
    visit club_sports_url
    click_on "New club sport"

    fill_in "Club profiles", with: @club_sport.club_profile_id
    fill_in "Sports", with: @club_sport.sport_id
    click_on "Create Club sport"

    assert_text "Club sport was successfully created"
    click_on "Back"
  end

  test "should update Club sport" do
    visit club_sport_url(@club_sport)
    click_on "Edit this club sport", match: :first

    fill_in "Club profiles", with: @club_sport.club_profile_id
    fill_in "Sports", with: @club_sport.sport_id
    click_on "Update Club sport"

    assert_text "Club sport was successfully updated"
    click_on "Back"
  end

  test "should destroy Club sport" do
    visit club_sport_url(@club_sport)
    accept_confirm { click_on "Destroy this club sport", match: :first }

    assert_text "Club sport was successfully destroyed"
  end
end
