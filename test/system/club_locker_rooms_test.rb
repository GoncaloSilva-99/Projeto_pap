require "application_system_test_case"

class ClubLockerRoomsTest < ApplicationSystemTestCase
  setup do
    @club_locker_room = club_locker_rooms(:one)
  end

  test "visiting the index" do
    visit club_locker_rooms_url
    assert_selector "h1", text: "Club locker rooms"
  end

  test "should create club locker room" do
    visit club_locker_rooms_url
    click_on "New club locker room"

    fill_in "Club profile", with: @club_locker_room.club_profile_id
    fill_in "Club training center", with: @club_locker_room.club_training_center_id
    fill_in "Name", with: @club_locker_room.name
    fill_in "Sport", with: @club_locker_room.sport_id
    click_on "Create Club locker room"

    assert_text "Club locker room was successfully created"
    click_on "Back"
  end

  test "should update Club locker room" do
    visit club_locker_room_url(@club_locker_room)
    click_on "Edit this club locker room", match: :first

    fill_in "Club profile", with: @club_locker_room.club_profile_id
    fill_in "Club training center", with: @club_locker_room.club_training_center_id
    fill_in "Name", with: @club_locker_room.name
    fill_in "Sport", with: @club_locker_room.sport_id
    click_on "Update Club locker room"

    assert_text "Club locker room was successfully updated"
    click_on "Back"
  end

  test "should destroy Club locker room" do
    visit club_locker_room_url(@club_locker_room)
    accept_confirm { click_on "Destroy this club locker room", match: :first }

    assert_text "Club locker room was successfully destroyed"
  end
end
