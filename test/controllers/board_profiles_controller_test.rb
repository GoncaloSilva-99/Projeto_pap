require "test_helper"

class BoardProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board_profile = board_profiles(:one)
  end

  test "should get index" do
    get board_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_board_profile_url
    assert_response :success
  end

  test "should create board_profile" do
    assert_difference("BoardProfile.count") do
      post board_profiles_url, params: { board_profile: { bio: @board_profile.bio, birth_date: @board_profile.birth_date, club_profile_id: @board_profile.club_profile_id, name: @board_profile.name, role: @board_profile.role, user_id: @board_profile.user_id } }
    end

    assert_redirected_to board_profile_url(BoardProfile.last)
  end

  test "should show board_profile" do
    get board_profile_url(@board_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_board_profile_url(@board_profile)
    assert_response :success
  end

  test "should update board_profile" do
    patch board_profile_url(@board_profile), params: { board_profile: { bio: @board_profile.bio, birth_date: @board_profile.birth_date, club_profile_id: @board_profile.club_profile_id, name: @board_profile.name, role: @board_profile.role, user_id: @board_profile.user_id } }
    assert_redirected_to board_profile_url(@board_profile)
  end

  test "should destroy board_profile" do
    assert_difference("BoardProfile.count", -1) do
      delete board_profile_url(@board_profile)
    end

    assert_redirected_to board_profiles_url
  end
end
