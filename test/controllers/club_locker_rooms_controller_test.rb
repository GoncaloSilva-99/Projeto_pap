require "test_helper"

class ClubLockerRoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_locker_room = club_locker_rooms(:one)
  end

  test "should get index" do
    get club_locker_rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_club_locker_room_url
    assert_response :success
  end

  test "should create club_locker_room" do
    assert_difference("ClubLockerRoom.count") do
      post club_locker_rooms_url, params: { club_locker_room: { club_profile_id: @club_locker_room.club_profile_id, club_training_center_id: @club_locker_room.club_training_center_id, name: @club_locker_room.name, sport_id: @club_locker_room.sport_id } }
    end

    assert_redirected_to club_locker_room_url(ClubLockerRoom.last)
  end

  test "should show club_locker_room" do
    get club_locker_room_url(@club_locker_room)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_locker_room_url(@club_locker_room)
    assert_response :success
  end

  test "should update club_locker_room" do
    patch club_locker_room_url(@club_locker_room), params: { club_locker_room: { club_profile_id: @club_locker_room.club_profile_id, club_training_center_id: @club_locker_room.club_training_center_id, name: @club_locker_room.name, sport_id: @club_locker_room.sport_id } }
    assert_redirected_to club_locker_room_url(@club_locker_room)
  end

  test "should destroy club_locker_room" do
    assert_difference("ClubLockerRoom.count", -1) do
      delete club_locker_room_url(@club_locker_room)
    end

    assert_redirected_to club_locker_rooms_url
  end
end
