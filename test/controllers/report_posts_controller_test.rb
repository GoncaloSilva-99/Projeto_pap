require "test_helper"

class ReportPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report_post = report_posts(:one)
  end

  test "should get index" do
    get report_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_report_post_url
    assert_response :success
  end

  test "should create report_post" do
    assert_difference("ReportPost.count") do
      post report_posts_url, params: { report_post: { content: @report_post.content, post_id: @report_post.post_id, resolved: @report_post.resolved } }
    end

    assert_redirected_to report_post_url(ReportPost.last)
  end

  test "should show report_post" do
    get report_post_url(@report_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_report_post_url(@report_post)
    assert_response :success
  end

  test "should update report_post" do
    patch report_post_url(@report_post), params: { report_post: { content: @report_post.content, post_id: @report_post.post_id, resolved: @report_post.resolved } }
    assert_redirected_to report_post_url(@report_post)
  end

  test "should destroy report_post" do
    assert_difference("ReportPost.count", -1) do
      delete report_post_url(@report_post)
    end

    assert_redirected_to report_posts_url
  end
end
