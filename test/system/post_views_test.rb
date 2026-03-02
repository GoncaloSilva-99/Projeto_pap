require "application_system_test_case"

class PostViewsTest < ApplicationSystemTestCase
  setup do
    @post_view = post_views(:one)
  end

  test "visiting the index" do
    visit post_views_url
    assert_selector "h1", text: "Post views"
  end

  test "should create post view" do
    visit post_views_url
    click_on "New post view"

    fill_in "Post", with: @post_view.post_id
    fill_in "User", with: @post_view.user_id
    click_on "Create Post view"

    assert_text "Post view was successfully created"
    click_on "Back"
  end

  test "should update Post view" do
    visit post_view_url(@post_view)
    click_on "Edit this post view", match: :first

    fill_in "Post", with: @post_view.post_id
    fill_in "User", with: @post_view.user_id
    click_on "Update Post view"

    assert_text "Post view was successfully updated"
    click_on "Back"
  end

  test "should destroy Post view" do
    visit post_view_url(@post_view)
    accept_confirm { click_on "Destroy this post view", match: :first }

    assert_text "Post view was successfully destroyed"
  end
end
