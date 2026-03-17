require "test_helper"

class ReportProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report_profile = report_profiles(:one)
  end

  test "should get index" do
    get report_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_report_profile_url
    assert_response :success
  end

  test "should create report_profile" do
    assert_difference("ReportProfile.count") do
      post report_profiles_url, params: { report_profile: { content: @report_profile.content, resolved: @report_profile.resolved, users_id: @report_profile.users_id } }
    end

    assert_redirected_to report_profile_url(ReportProfile.last)
  end

  test "should show report_profile" do
    get report_profile_url(@report_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_report_profile_url(@report_profile)
    assert_response :success
  end

  test "should update report_profile" do
    patch report_profile_url(@report_profile), params: { report_profile: { content: @report_profile.content, resolved: @report_profile.resolved, users_id: @report_profile.users_id } }
    assert_redirected_to report_profile_url(@report_profile)
  end

  test "should destroy report_profile" do
    assert_difference("ReportProfile.count", -1) do
      delete report_profile_url(@report_profile)
    end

    assert_redirected_to report_profiles_url
  end
end
