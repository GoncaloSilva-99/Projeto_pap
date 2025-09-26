require "test_helper"

class AdminProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_profile = admin_profiles(:one)
  end

  test "should get index" do
    get admin_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_profile_url
    assert_response :success
  end

  test "should create admin_profile" do
    assert_difference("AdminProfile.count") do
      post admin_profiles_url, params: { admin_profile: { name: @admin_profile.name, user_id: @admin_profile.user_id } }
    end

    assert_redirected_to admin_profile_url(AdminProfile.last)
  end

  test "should show admin_profile" do
    get admin_profile_url(@admin_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_profile_url(@admin_profile)
    assert_response :success
  end

  test "should update admin_profile" do
    patch admin_profile_url(@admin_profile), params: { admin_profile: { name: @admin_profile.name, user_id: @admin_profile.user_id } }
    assert_redirected_to admin_profile_url(@admin_profile)
  end

  test "should destroy admin_profile" do
    assert_difference("AdminProfile.count", -1) do
      delete admin_profile_url(@admin_profile)
    end

    assert_redirected_to admin_profiles_url
  end
end
