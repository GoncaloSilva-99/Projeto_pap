require "test_helper"

class ClubBalancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_balance = club_balances(:one)
  end

  test "should get index" do
    get club_balances_url
    assert_response :success
  end

  test "should get new" do
    get new_club_balance_url
    assert_response :success
  end

  test "should create club_balance" do
    assert_difference("ClubBalance.count") do
      post club_balances_url, params: { club_balance: { club_profile_id: @club_balance.club_profile_id, value: @club_balance.value } }
    end

    assert_redirected_to club_balance_url(ClubBalance.last)
  end

  test "should show club_balance" do
    get club_balance_url(@club_balance)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_balance_url(@club_balance)
    assert_response :success
  end

  test "should update club_balance" do
    patch club_balance_url(@club_balance), params: { club_balance: { club_profile_id: @club_balance.club_profile_id, value: @club_balance.value } }
    assert_redirected_to club_balance_url(@club_balance)
  end

  test "should destroy club_balance" do
    assert_difference("ClubBalance.count", -1) do
      delete club_balance_url(@club_balance)
    end

    assert_redirected_to club_balances_url
  end
end
