require "test_helper"

class PlayerProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_profile = player_profiles(:one)
  end

  test "should get index" do
    get player_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_player_profile_url
    assert_response :success
  end

  test "should create player_profile" do
    assert_difference("PlayerProfile.count") do
      post player_profiles_url, params: { player_profile: { bio: @player_profile.bio, birth_date: @player_profile.birth_date, club_profile_id: @player_profile.club_profile_id, contact: @player_profile.contact, name: @player_profile.name, parents_contact: @player_profile.parents_contact, position: @player_profile.position, user_id: @player_profile.user_id } }
    end

    assert_redirected_to player_profile_url(PlayerProfile.last)
  end

  test "should show player_profile" do
    get player_profile_url(@player_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_profile_url(@player_profile)
    assert_response :success
  end

  test "should update player_profile" do
    patch player_profile_url(@player_profile), params: { player_profile: { bio: @player_profile.bio, birth_date: @player_profile.birth_date, club_profile_id: @player_profile.club_profile_id, contact: @player_profile.contact, name: @player_profile.name, parents_contact: @player_profile.parents_contact, position: @player_profile.position, user_id: @player_profile.user_id } }
    assert_redirected_to player_profile_url(@player_profile)
  end

  test "should destroy player_profile" do
    assert_difference("PlayerProfile.count", -1) do
      delete player_profile_url(@player_profile)
    end

    assert_redirected_to player_profiles_url
  end
end
