require "application_system_test_case"

class PostSavesTest < ApplicationSystemTestCase
  setup do
    @post_safe = post_saves(:one)
  end

  test "visiting the index" do
    visit post_saves_url
    assert_selector "h1", text: "Post saves"
  end

  test "should create post safe" do
    visit post_saves_url
    click_on "New post safe"

    fill_in "Post", with: @post_safe.post_id
    fill_in "User", with: @post_safe.user_id
    click_on "Create Post safe"

    assert_text "Post safe was successfully created"
    click_on "Back"
  end

  test "should update Post safe" do
    visit post_safe_url(@post_safe)
    click_on "Edit this post safe", match: :first

    fill_in "Post", with: @post_safe.post_id
    fill_in "User", with: @post_safe.user_id
    click_on "Update Post safe"

    assert_text "Post safe was successfully updated"
    click_on "Back"
  end

  test "should destroy Post safe" do
    visit post_safe_url(@post_safe)
    accept_confirm { click_on "Destroy this post safe", match: :first }

    assert_text "Post safe was successfully destroyed"
  end
end
