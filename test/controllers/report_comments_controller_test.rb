require "test_helper"

class ReportCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report_comment = report_comments(:one)
  end

  test "should get index" do
    get report_comments_url
    assert_response :success
  end

  test "should get new" do
    get new_report_comment_url
    assert_response :success
  end

  test "should create report_comment" do
    assert_difference("ReportComment.count") do
      post report_comments_url, params: { report_comment: { content: @report_comment.content, post_comment_id: @report_comment.post_comment_id, resolved: @report_comment.resolved } }
    end

    assert_redirected_to report_comment_url(ReportComment.last)
  end

  test "should show report_comment" do
    get report_comment_url(@report_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_report_comment_url(@report_comment)
    assert_response :success
  end

  test "should update report_comment" do
    patch report_comment_url(@report_comment), params: { report_comment: { content: @report_comment.content, post_comment_id: @report_comment.post_comment_id, resolved: @report_comment.resolved } }
    assert_redirected_to report_comment_url(@report_comment)
  end

  test "should destroy report_comment" do
    assert_difference("ReportComment.count", -1) do
      delete report_comment_url(@report_comment)
    end

    assert_redirected_to report_comments_url
  end
end
