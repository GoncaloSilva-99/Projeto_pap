require "test_helper"

class ClubIncomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_income = club_incomes(:one)
  end

  test "should get index" do
    get club_incomes_url
    assert_response :success
  end

  test "should get new" do
    get new_club_income_url
    assert_response :success
  end

  test "should create club_income" do
    assert_difference("ClubIncome.count") do
      post club_incomes_url, params: { club_income: { club_profile_id: @club_income.club_profile_id, date: @club_income.date, description: @club_income.description, value: @club_income.value } }
    end

    assert_redirected_to club_income_url(ClubIncome.last)
  end

  test "should show club_income" do
    get club_income_url(@club_income)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_income_url(@club_income)
    assert_response :success
  end

  test "should update club_income" do
    patch club_income_url(@club_income), params: { club_income: { club_profile_id: @club_income.club_profile_id, date: @club_income.date, description: @club_income.description, value: @club_income.value } }
    assert_redirected_to club_income_url(@club_income)
  end

  test "should destroy club_income" do
    assert_difference("ClubIncome.count", -1) do
      delete club_income_url(@club_income)
    end

    assert_redirected_to club_incomes_url
  end
end
