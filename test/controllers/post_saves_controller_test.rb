require "test_helper"

class PostSavesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_safe = post_saves(:one)
  end

  test "should get index" do
    get post_saves_url
    assert_response :success
  end

  test "should get new" do
    get new_post_safe_url
    assert_response :success
  end

  test "should create post_safe" do
    assert_difference("PostSafe.count") do
      post post_saves_url, params: { post_safe: { post_id: @post_safe.post_id, user_id: @post_safe.user_id } }
    end

    assert_redirected_to post_safe_url(PostSafe.last)
  end

  test "should show post_safe" do
    get post_safe_url(@post_safe)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_safe_url(@post_safe)
    assert_response :success
  end

  test "should update post_safe" do
    patch post_safe_url(@post_safe), params: { post_safe: { post_id: @post_safe.post_id, user_id: @post_safe.user_id } }
    assert_redirected_to post_safe_url(@post_safe)
  end

  test "should destroy post_safe" do
    assert_difference("PostSafe.count", -1) do
      delete post_safe_url(@post_safe)
    end

    assert_redirected_to post_saves_url
  end
end
