require "test_helper"

class PostViewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_view = post_views(:one)
  end

  test "should get index" do
    get post_views_url
    assert_response :success
  end

  test "should get new" do
    get new_post_view_url
    assert_response :success
  end

  test "should create post_view" do
    assert_difference("PostView.count") do
      post post_views_url, params: { post_view: { post_id: @post_view.post_id, user_id: @post_view.user_id } }
    end

    assert_redirected_to post_view_url(PostView.last)
  end

  test "should show post_view" do
    get post_view_url(@post_view)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_view_url(@post_view)
    assert_response :success
  end

  test "should update post_view" do
    patch post_view_url(@post_view), params: { post_view: { post_id: @post_view.post_id, user_id: @post_view.user_id } }
    assert_redirected_to post_view_url(@post_view)
  end

  test "should destroy post_view" do
    assert_difference("PostView.count", -1) do
      delete post_view_url(@post_view)
    end

    assert_redirected_to post_views_url
  end
end
