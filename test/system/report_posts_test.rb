require "application_system_test_case"

class ReportPostsTest < ApplicationSystemTestCase
  setup do
    @report_post = report_posts(:one)
  end

  test "visiting the index" do
    visit report_posts_url
    assert_selector "h1", text: "Report posts"
  end

  test "should create report post" do
    visit report_posts_url
    click_on "New report post"

    fill_in "Content", with: @report_post.content
    fill_in "Post", with: @report_post.post_id
    check "Resolved" if @report_post.resolved
    click_on "Create Report post"

    assert_text "Report post was successfully created"
    click_on "Back"
  end

  test "should update Report post" do
    visit report_post_url(@report_post)
    click_on "Edit this report post", match: :first

    fill_in "Content", with: @report_post.content
    fill_in "Post", with: @report_post.post_id
    check "Resolved" if @report_post.resolved
    click_on "Update Report post"

    assert_text "Report post was successfully updated"
    click_on "Back"
  end

  test "should destroy Report post" do
    visit report_post_url(@report_post)
    accept_confirm { click_on "Destroy this report post", match: :first }

    assert_text "Report post was successfully destroyed"
  end
end
